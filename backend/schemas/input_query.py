from enum import Enum
from typing import Optional

from pydantic import BaseModel, constr


class UserCreate(BaseModel):
    phone: constr(strip_whitespace=True, pattern=r'^\+998\d{9}$') = '+998901234567'
    password: str


class UserLogin(BaseModel):
    phone: constr(strip_whitespace=True, pattern=r'^\+998\d{9}$') = '+998901234567'
    password: str


class GenderClass(str, Enum):
    BOY = "boy"  # will be active soon
    GIRL = "girl"


class Child(BaseModel):
    birthday: str = "20.07.2023"
    gender: GenderClass
    weight: float = 3.5


class Audio(BaseModel):
    audio_url: str = "https://commondatastorage.googleapis.com/codeskulptor-assets/Evillaugh.ogg"


class SettingsCreate(BaseModel):
    lang: str = "uz"
    dark_mode: bool = False
    notification: bool = False


class ChatInput(BaseModel):
    message: str


class ChatOutput(BaseModel):
    input: str
    output: str
    user_id: str

    class Config:  # tells pydantic to convert even non dict obj to json
        from_attributes = True


class Token(BaseModel):
    access_token: str
    token_type: str


class TokenData(BaseModel):
    phone: Optional[str] = None
