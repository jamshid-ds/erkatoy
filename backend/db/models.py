from enum import Enum

from sqlalchemy import Column, Integer, String, ForeignKey, Float, Boolean, Enum as SqlEnum

from db.base_class import Base


class Users(Base):
    phone = Column(String, primary_key=True, index=True)
    password = Column(String)


class Children(Base):
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String, ForeignKey('users.phone'))
    birthday = Column(String)
    gender = Column(String)
    weight = Column(Float)


class ChildCry(Base):
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String, ForeignKey('users.phone'))
    audio_url = Column(String)
    is_finished = Column(Boolean, default=False)
    result = Column(String, nullable=True)


class Languages(Enum):
    uz = "uz"
    ru = "ru"


class Settings(Base):
    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(String, ForeignKey('users.phone'))
    lang = Column(SqlEnum(Languages), nullable=False, default=Languages.uz)
    dark_mode = Column(Boolean, default=False)
    notification = Column(Boolean, default=False)
