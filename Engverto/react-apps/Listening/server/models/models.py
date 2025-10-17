# server/models/models.py

from app.db import db #
# Removed redundant import of db from app.models.db
from datetime import datetime
from flask_sqlalchemy import SQLAlchemy
db = SQLAlchemy()

class ListeningTest(db.Model):
    __tablename__ = 'listening_tests'
    id = db.Column(db.String, primary_key=True)
    title = db.Column(db.String, nullable=False)
    audio_url = db.Column(db.String)
    transcript = db.Column(db.JSON)
    level = db.Column(db.String)
    created_at = db.Column(db.DateTime)

    questions = db.relationship("ListeningQuestion", backref="test", lazy=True)

class ListeningQuestion(db.Model):
    __tablename__ = 'listening_questions'
    id = db.Column(db.String, primary_key=True)
    test_id = db.Column(db.String, db.ForeignKey('listening_tests.id'))
    question_type = db.Column(db.String)
    question_text = db.Column(db.Text)
    options = db.Column(db.JSON)
    correct_answer = db.Column(db.Text)

# app/models.py


class ListeningHistory(db.Model):
    __tablename__ = "listening_history"

    id = db.Column(db.String, primary_key=True)
    test_id = db.Column(db.String, nullable=False)
    test_title = db.Column(db.String, nullable=False)
    score = db.Column(db.Integer, nullable=False)
    total = db.Column(db.Integer, nullable=False)
    timestamp = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)

