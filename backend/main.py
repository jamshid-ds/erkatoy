import logging
import sys

from environs import Env
from fastapi import FastAPI
from fastapi.exceptions import RequestValidationError
from starlette.requests import Request
from starlette.responses import JSONResponse

from apis.base import api_router
from apis.v1.route_chat import validation_exception_handler
from core.config import settings
from db.base_class import Base
from db.session import engine
from session import verify_session

env = Env()
env.read_env()

logging.basicConfig(level=logging.INFO, format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
                    handlers=[logging.StreamHandler(sys.stdout)])


def create_tables():
    Base.metadata.create_all(bind=engine)


def include_router(app):
    app.include_router(api_router)


def start_application():
    foo_app = FastAPI(title=settings.PROJECT_NAME, description="Endpoints for BabySitter", docs_url='/',
                      version=settings.PROJECT_VERSION)
    foo_app.add_exception_handler(RequestValidationError, validation_exception_handler)

    create_tables()
    include_router(foo_app)
    return foo_app


app = start_application()
