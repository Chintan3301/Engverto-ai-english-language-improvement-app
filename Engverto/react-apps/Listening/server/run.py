from flask import Flask
from flask_cors import CORS
from app.models import db
from app.routes import test_routes
from app.config import DATABASE_URI

app = Flask(__name__)
CORS(app)

app.config["SQLALCHEMY_DATABASE_URI"] = DATABASE_URI
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False

db.init_app(app)
app.register_blueprint(test_routes, url_prefix="/api")

@app.route("/")
def home():
    return "🎧 Listening API is running!"


if __name__ == "__main__":
  
    app.run(debug=True, port=5003)
