from itsdangerous import URLSafeTimedSerializer
from environs import Env
env = Env()
env.read_env()

SECRET_KEY = "N3UTDcml4R4XNc9s8yoKYcRuHW3dDZYZ"
SESSION_EXPIRATION = env.int('SESSION_EXPIRATION')  # Session expiration time in seconds (e.g., 2 hour)

serializer = URLSafeTimedSerializer(SECRET_KEY)


def create_session(data: dict) -> str:
    return serializer.dumps(data)


def verify_session(token: str) -> dict:
    try:
        data = serializer.loads(token, max_age=SESSION_EXPIRATION)
        return data
    except Exception as e:
        return None
