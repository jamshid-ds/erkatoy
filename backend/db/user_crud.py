import logging
import sys

from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import Session

from db.models import Users, Children, ChildCry, Settings

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
                    handlers=[logging.StreamHandler(sys.stdout)])


def create_user(db: Session, phone: str, password: str):
    db_user = Users(phone=phone, password=password)
    try:
        db.add(db_user)
        db.commit()
        db.refresh(db_user)
        logging.info("Users created successfully.")
        return db_user
    except Exception as e:
        db.rollback()  # Rollback the transaction to avoid any potential issues
        logging.warning(e)
        return None


def create_child(db: Session, user_id: str, birthday: str, gender: str, weight: float):
    try:
        # Check if the child entry with the given user_id already exists
        db_child = db.query(Children).filter(Children.user_id == user_id).first()

        if db_child:
            # Update existing entry
            db_child.birthday = birthday
            db_child.gender = gender
            db_child.weight = weight
            logging.info("Child updated successfully.")
        else:
            # Create new entry
            db_child = Children(user_id=user_id, birthday=birthday, gender=gender, weight=weight)
            db.add(db_child)
            logging.info("Child created successfully.")

        db.commit()
        db.refresh(db_child)
        return db_child

    except SQLAlchemyError as e:
        db.rollback()  # Rollback the transaction to avoid any potential issues
        logging.warning(f"Transaction failed: {e}")
        return None


def create_audio(db: Session, url: str, user_id: str):
    db_cry = ChildCry(user_id=user_id, audio_url=url)
    try:
        db.add(db_cry)
        db.commit()
        db.refresh(db_cry)
        logging.info("Audio created successfully.")
        return db_cry
    except Exception as e:
        db.rollback()  # Rollback the transaction to avoid any potential issues
        logging.warning(e)
        return None


def create_settings(db: Session, lang: str, user_id: str, dark_mode: bool, notification: bool):
    try:
        # Check if the child entry with the given user_id already exists
        db_settings = db.query(Settings).filter(Settings.user_id == user_id).first()

        if db_settings:
            # Update existing entry
            db_settings.lang = lang
            db_settings.dark_mode = dark_mode
            db_settings.notification = notification
            logging.info("Settings updated successfully.")
        else:
            # Create new entry
            db_settings = Settings(user_id=user_id, lang=lang, dark_mode=dark_mode, notification=notification)
            db.add(db_settings)
            logging.info("Settings created successfully.")

        db.commit()
        db.refresh(db_settings)
        return db_settings

    except SQLAlchemyError as e:
        db.rollback()  # Rollback the transaction to avoid any potential issues
        logging.warning(f"Transaction failed: {e}")
        return None
