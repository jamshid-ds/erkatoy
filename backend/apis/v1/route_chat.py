import logging
import os
import sys
from datetime import datetime, timedelta, timezone
from typing import Annotated
from uuid import uuid4

import jwt
import pandas as pd
import requests
from environs import Env
from fastapi import APIRouter, Depends, Request, Query
from fastapi.exceptions import RequestValidationError, HTTPException
from fastapi.responses import JSONResponse
from fastapi.security import OAuth2PasswordBearer
from jwt.exceptions import InvalidTokenError
from passlib.context import CryptContext
from sqlalchemy import delete, table
from starlette import status
from sqlalchemy.orm import Session

from db.models import Users
from chatbot.qa_chain import invoke_agent_with_retry
from cry_detector.cry_model import cry_classification
from db.models import Settings, Children
from db.session import get_db
from db.user_crud import create_user, create_child, create_audio, create_settings
from schedule_script import get_file_name, files, calculate_age, get_current_time, find_activity
from schemas.input_query import Child, Audio, SettingsCreate, ChatInput, UserCreate, TokenData, Token, UserLogin

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
                    handlers=[logging.StreamHandler(sys.stdout)])


env = Env()
env.read_env()
router = APIRouter()


async def validation_exception_handler(request: Request, exc: RequestValidationError):
    errors = exc.errors()
    custom_errors = []

    for error in errors:
        field = error.get('loc')[-1]
        message = error.get('msg')
        custom_errors.append({"field": field, "message": message})
    logging.error(custom_errors)
    return JSONResponse(status_code=422, content={"detail": custom_errors})


def update_passwords_to_encoded(db: Session):
    users = db.query(Users).all()
    for user in users:
        user.password = get_password_hash(user.password)
        db.add(user)
    db.commit()


def save_audio(audio_url: str, path: str):
    try:
        response = requests.get(audio_url)
        if response.status_code == 200:
            file = open(path, 'wb')
            file.write(response.content)
            file.close()
            return True
        else:
            return False
    except Exception as e:
        logging.error(f"Failed to save audio file: {e}")
        return False


SECRET_KEY = "6yzVPryC1O3KWMEEUXerlcRzuYDeehWO"
ALGORITHM = "HS256"
EXPIRE_DAYS = 30

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="login")


def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def get_password_hash(password):
    return pwd_context.hash(password)


def create_access_token(data: dict, expires_delta: timedelta | None = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.now(timezone.utc) + expires_delta
    else:
        expire = datetime.now(timezone.utc) + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt


async def get_current_user(token: Annotated[str, Depends(oauth2_scheme)], db: Session = Depends(get_db)):
    credentials_exception = HTTPException(status_code=status.HTTP_401_UNAUTHORIZED,
                                          detail="Could not validate credentials",
                                          headers={"WWW-Authenticate": "Bearer"}, )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        phone: str = payload.get("sub")
        if phone is None:
            raise credentials_exception
        token_data = TokenData(phone=phone)
    except InvalidTokenError:
        raise credentials_exception
    user = db.query(Users).filter(Users.phone == token_data.phone).first()
    if user is None:
        raise credentials_exception
    return user


@router.post("/register")
async def register_user(user: UserCreate, db: Session = Depends(get_db)):
    db_user = db.query(Users).filter(Users.phone == user.phone).first()
    if db_user:
        raise HTTPException(status_code=400, detail="User already exists!")

    hashed_password = get_password_hash(user.password)
    db_user = create_user(db, phone=user.phone, password=hashed_password)
    if db_user:
        create_settings(db, user_id=db_user.phone, lang='uz', notification=False, dark_mode=False)
        return JSONResponse(status_code=200, content={"message": "User created successfully!", "phone": db_user.phone})
    else:
        raise HTTPException(status_code=400, detail="Error!")


@router.post("/login", response_model=Token)
async def login_user(user: UserLogin, db: Session = Depends(get_db)):
    db_user = db.query(Users).filter(Users.phone == user.phone).first()
    if not db_user or not verify_password(user.password, db_user.password):
        raise HTTPException(status_code=400, detail="Invalid phone or password")
    access_token_expires = timedelta(days=EXPIRE_DAYS)
    access_token = create_access_token(data={"sub": db_user.phone}, expires_delta=access_token_expires)
    return {"access_token": access_token, "token_type": "bearer"}


@router.get("/get_user")
async def get_user(current_user: Users = Depends(get_current_user), db: Session = Depends(get_db)):
    setting = db.query(Settings).filter(Settings.user_id == current_user.phone).first()
    if setting:
        return JSONResponse(status_code=200,
                            content={"message": "Success!", "user_id": current_user.phone, "lang": setting.lang.value,
                                     "notification": setting.notification, "dark_mode": setting.dark_mode})
    else:
        return JSONResponse(status_code=200, content={"message": "Success!", "user_id": current_user.phone})


@router.post("/child_info")
async def bola_malumoti(child: Child, db: Session = Depends(get_db), current_user: Users = Depends(get_current_user)):
    child_created = create_child(db, user_id=current_user.phone, gender=child.gender, weight=child.weight,
                                 birthday=child.birthday)
    if child_created:
        return JSONResponse(status_code=200,
                            content={"message": "Success!", "user_id": current_user.phone, "gender": child.gender,
                                     "weight": child.weight, "birthday": child.birthday})
    else:
        raise HTTPException(status_code=400, detail="Failed to create child!")


@router.get("/get_child_info")
async def bola_malumoti(db: Session = Depends(get_db), current_user: Users = Depends(get_current_user)):
    child = db.query(Children).filter(Children.user_id == current_user.phone).first()
    if child:
        return JSONResponse(status_code=200,
                            content={"message": "Success!", "user_id": current_user.phone, "gender": child.gender,
                                     "weight": child.weight, "birthday": child.birthday})
    else:
        raise HTTPException(status_code=400, detail="Failed to create child!")


@router.post("/cry_classify")
async def cry_classify(audio: Audio, db: Session = Depends(get_db), current_user: Users = Depends(get_current_user)):
    is_created = create_audio(db, url=audio.audio_url, user_id=current_user.phone)
    if is_created:
        audio_path = f"{env.str('BASE_PATH')}/audios/{current_user.phone}"
        if not os.path.exists(audio_path):
            os.mkdir(audio_path)
        audio_id = uuid4()
        full_path = f"{audio_path}/{audio_id}.wav"
        success = save_audio(audio.audio_url, full_path)
        if success:
            result = cry_classification(full_path)
            return JSONResponse(status_code=200, content={"message": "Success!", "result": result})
        else:
            return JSONResponse(status_code=400, content={"message": "Failed to create audio!"})
    else:
        raise HTTPException(status_code=400, detail="Failed to create child!")


@router.post("/settings")
async def sozlamalar(setting: SettingsCreate, db: Session = Depends(get_db),
                     current_user: Users = Depends(get_current_user)):
    settings_created = create_settings(db, user_id=current_user.phone, lang=setting.lang,
                                       notification=setting.notification, dark_mode=setting.dark_mode)
    if settings_created:
        return JSONResponse(status_code=200,
                            content={"message": "Success!", "user_id": current_user.phone, "lang": setting.lang,
                                     "notification": setting.notification, "dark_mode": setting.dark_mode})
    else:
        raise HTTPException(status_code=400, detail="Failed to create settings!")


@router.get("/get_settings")
async def sozlamalar(db: Session = Depends(get_db), current_user: Users = Depends(get_current_user)):
    setting = db.query(Settings).filter(Settings.user_id == current_user.phone).first()
    if setting:
        return JSONResponse(status_code=200,
                            content={"message": "Success!", "user_id": current_user.phone, "lang": setting.lang.value,
                                     "notification": setting.notification, "dark_mode": setting.dark_mode})
    else:
        raise HTTPException(status_code=400, detail="Not Found!")


@router.get("/current_activity")
async def kunlik_jadval(db: Session = Depends(get_db), current_user: Users = Depends(get_current_user)):
    child = db.query(Children).filter(Children.user_id == current_user.phone).first()
    month = calculate_age(child.birthday)
    try:
        file_name = get_file_name(month)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

    df = files[file_name]
    current_time = get_current_time()
    activity = find_activity(df, current_time)
    return {"time": current_time, "activity": activity}


@router.get("/all_activities")
async def kunlik_jadval(db: Session = Depends(get_db), current_user: Users = Depends(get_current_user)):
    child = db.query(Children).filter(Children.user_id == current_user.phone).first()
    month = calculate_age(child.birthday)
    try:
        file_name = get_file_name(month)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

    df = files[file_name]
    df = df.set_index('Vaqt')['Faoliyat'].to_dict()
    return df


@router.get("/health")
async def salomatlik(limit: int = Query(4, le=100), all: bool = Query(False)):
    df = pd.read_csv("kasalliklar.csv")
    if all:
        result = df.to_dict('records')
    else:
        result = df.head(limit).to_dict('records')
    return result


@router.post("/chat", status_code=status.HTTP_201_CREATED)
async def send_message(query: ChatInput, current_user: Users = Depends(get_current_user)):
    agent_response = await invoke_agent_with_retry(query.message, current_user.phone)
    response = {'input': query.message, 'output': agent_response, 'user_id': current_user.phone}
    # create_new_message(response.copy(), db)
    return response


@router.get("/delete_chat_history", status_code=status.HTTP_200_OK)
async def delete_messages(db: Session = Depends(get_db)):
    db.execute(delete(table('message_store')))
    db.commit()
    return JSONResponse(status_code=200, content={"message": "Success!"})
