# server/models/models.py

from app.db import db 

class ListeningTest(db.Model):
    __tablename__ = 'listening_tests'
    id = db.Column(db.String, primary_key=True)
    title = db.Column(db.String)
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
