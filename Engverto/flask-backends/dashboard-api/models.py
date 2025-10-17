from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

# 🔹 Generic Activity Table (for /api/progress)
class Activity(db.Model):
    __tablename__ = 'user_activity'  # ✅ update this line
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    module = db.Column(db.String(50), nullable=False)
    score = db.Column(db.Integer, nullable=False)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

# 🔹 Reading User Answers
class ReadingAnswer(db.Model):
    __tablename__ = 'reading_answers'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    question_id = db.Column(db.Integer)
    user_answer = db.Column(db.Text)
    score = db.Column(db.Integer)
    feedback = db.Column(db.Text)
    submitted_at = db.Column(db.DateTime, default=datetime.utcnow)
    test_id = db.Column(db.String(100))  # optional: to group answers by test

# 🔹 Writing Feedback
class WritingFeedback(db.Model):
    __tablename__ = 'writing_feedback'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    writing_type = db.Column(db.String(50))
    situation = db.Column(db.Text)
    task = db.Column(db.Text)
    prompt_text = db.Column(db.Text)
    user_writing = db.Column(db.Text)
    score_total = db.Column(db.Integer)

    score_content_relevance = db.Column(db.Integer)
    score_content_depth = db.Column(db.Integer)
    score_organization_paragraphs = db.Column(db.Integer)
    score_organization_coherence = db.Column(db.Integer)
    score_grammar_tenses = db.Column(db.Integer)
    score_grammar_agreement_punctuation = db.Column(db.Integer)
    score_vocab_range = db.Column(db.Integer)
    score_vocab_idioms = db.Column(db.Integer)
    score_style_audience = db.Column(db.Integer)

    comment_grammar = db.Column(db.Text)
    comment_vocabulary = db.Column(db.Text)
    comment_structure = db.Column(db.Text)
    comment_tone = db.Column(db.Text)

    rewrite_suggestion = db.Column(db.Text)
    improved_version = db.Column(db.Text)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

# 🔹 Listening History
class ListeningHistory(db.Model):
    __tablename__ = 'listening_history'
    id = db.Column(db.String, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    test_id = db.Column(db.String)
    test_title = db.Column(db.String)
    score = db.Column(db.Integer)
    total = db.Column(db.Integer)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)

# 🔹 Speaking Sessions
class SpeakingSession(db.Model):
    __tablename__ = 'speaking_sessions'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, nullable=False)
    session_type = db.Column(db.String)
    timestamp = db.Column(db.DateTime, default=datetime.utcnow)
    conversation = db.Column(db.JSON)
    feedback = db.Column(db.Text)
    fluency_score = db.Column(db.Integer)
