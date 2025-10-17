from . import db

class Passage(db.Model):
    __tablename__ = 'reading_passages'

    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100))
    content = db.Column(db.Text)
    level = db.Column(db.String(50))
    questions = db.relationship('Question', backref='passage', lazy=True, cascade="all, delete-orphan")


class Question(db.Model):
    __tablename__ = 'reading_questions'

    id = db.Column(db.Integer, primary_key=True)
    passage_id = db.Column(db.Integer, db.ForeignKey('reading_passages.id'), nullable=False)
    question_text = db.Column(db.Text)
    correct_answer = db.Column(db.Text)
    type = db.Column(db.String(20))  # 'mcq' or 'short'
    skill = db.Column(db.String(50))
    options = db.Column(db.Text)  


class UserAnswer(db.Model):
    __tablename__ = 'reading_answers'

    id = db.Column(db.Integer, primary_key=True)
    question_id = db.Column(db.Integer, db.ForeignKey('reading_questions.id'), nullable=False)
    user_id = db.Column(db.Integer, nullable=True)  # Optional: depends on auth system
    user_answer = db.Column(db.Text)
    score = db.Column(db.Integer)
    feedback = db.Column(db.Text)
    test_id = db.Column(db.String(36))  # UUID as string
    submitted_at = db.Column(db.DateTime, server_default=db.func.now())
