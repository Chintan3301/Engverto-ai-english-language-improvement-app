from flask import Flask
from flask_cors import CORS
from .models import db
from .routes import test_routes

app = Flask(__name__)

# Your database config
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:Asdfg%40123@localhost:5432/listening_app'

app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)
app.register_blueprint(test_routes, url_prefix="/api")
CORS(app, origins=["http://localhost:3003"])
