from flask import Flask
from flask_sqlalchemy import SQLAlchemy  # type: ignore
from flask_cors import CORS
from .config import Config

db = SQLAlchemy()

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)

    # ✅ Restrict CORS to frontend React app
    CORS(app, origins="http://localhost:3001")

    from .routes import main
    app.register_blueprint(main)

    return app
