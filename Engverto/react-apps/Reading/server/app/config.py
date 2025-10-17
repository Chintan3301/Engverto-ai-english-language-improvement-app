import os
from dotenv import load_dotenv

load_dotenv()  # This reads from .env

class Config:
    SQLALCHEMY_DATABASE_URI = os.getenv('DATABASE_URL')
    SQLALCHEMY_TRACK_MODIFICATIONS = False
