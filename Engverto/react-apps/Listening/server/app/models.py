# app/models.py

from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

class ListeningTest(db.Model):
    __tablename__ = 'listening_tests'
    id = db.Column(db.String, primary_key=True)
    title = db.Column(db.Text, nullable=False)
    audio_url = db.Column(db.Text, nullable=False)
    transcript = db.Column(db.JSON)
    level = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

    questions = db.relationship('ListeningQuestion', backref='test', cascade="all, delete-orphan")

class ListeningQuestion(db.Model):
    __tablename__ = 'listening_questions'
    id = db.Column(db.String, primary_key=True)
    test_id = db.Column(db.String, db.ForeignKey('listening_tests.id', ondelete="CASCADE"))
    question_type = db.Column(db.Text)
    question_text = db.Column(db.Text)
    options = db.Column(db.JSON)
    correct_answer = db.Column(db.Text)

class ListeningHistory(db.Model):
    __tablename__ = 'listening_history'
    id = db.Column(db.String, primary_key=True)
    user_id = db.Column(db.Integer)  # ← Assumes users table already exists
    test_id = db.Column(db.String, db.ForeignKey('listening_tests.id'))
    test_title = db.Column(db.Text)
    score = db.Column(db.Integer)
    total = db.Column(db.Integer)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
