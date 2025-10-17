# config.py

DB_USERNAME = 'postgres'  # or your username
DB_PASSWORD = 'Asdfg%40123'
DB_HOST = 'localhost'
DB_NAME = 'engverto_dash'
DB_PORT = '5433' 

SQLALCHEMY_DATABASE_URI = f'postgresql://{DB_USERNAME}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}'
SQLALCHEMY_TRACK_MODIFICATIONS = False