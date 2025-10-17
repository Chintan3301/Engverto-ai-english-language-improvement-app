from flask import Flask, jsonify, request
from flask_cors import CORS
from models import db, Activity, ReadingAnswer, WritingFeedback, ListeningHistory, SpeakingSession
import config
import openai
import os
from datetime import datetime
from dotenv import load_dotenv

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = config.SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = config.SQLALCHEMY_TRACK_MODIFICATIONS

db.init_app(app)
CORS(app)

# ✅ Progress Summary (average score per module)
@app.route('/api/progress/<int:user_id>', methods=['GET'])
def get_user_progress(user_id):
    modules = ['reading', 'writing', 'listening', 'speaking']
    result = {}

    for module in modules:
        scores = Activity.query.filter_by(user_id=user_id, module=module).all()
        if scores:
            avg = sum([s.score for s in scores]) / len(scores)
        else:
            avg = 0
        result[module] = round(avg)

    result['streak'] = 5  # Placeholder
    return jsonify(result)

# ✅ Recent Activity (actual latest data from all modules)
@app.route('/api/recent-activity/<int:user_id>', methods=['GET'])
def recent_activity(user_id):
    result = {}

    # Reading → Grouped by test_id
    reading = db.session.query(ReadingAnswer)\
        .filter_by(user_id=user_id)\
        .order_by(ReadingAnswer.submitted_at.desc()).first()
    if reading:
        test_id = reading.test_id
        total = db.session.query(ReadingAnswer).filter_by(test_id=test_id).count()
        score = db.session.query(db.func.sum(ReadingAnswer.score)).filter_by(test_id=test_id).scalar()
        result['reading'] = {
            "score": score,
            "total": total,
            "submitted_at": reading.submitted_at.strftime('%Y-%m-%d')
        }

    # Writing
    writing = db.session.query(WritingFeedback)\
        .filter_by(user_id=user_id)\
        .order_by(WritingFeedback.created_at.desc()).first()
    if writing:
        result['writing'] = {
            "score": writing.score_total,
            "total": 100,
            "submitted_at": writing.created_at.strftime('%Y-%m-%d')
        }

    # Listening
    listening = db.session.query(ListeningHistory)\
        .filter_by(user_id=user_id)\
        .order_by(ListeningHistory.timestamp.desc()).first()
    if listening:
        result['listening'] = {
            "score": listening.score,
            "total": listening.total,
            "submitted_at": listening.timestamp.strftime('%Y-%m-%d')
        }

    # Speaking
    speaking = db.session.query(SpeakingSession)\
        .filter_by(user_id=user_id)\
        .order_by(SpeakingSession.timestamp.desc()).first()
    if speaking:
        result['speaking'] = {
            "score": speaking.fluency_score,
            "total": 100,
            "submitted_at": speaking.timestamp.strftime('%Y-%m-%d')
        }

    return jsonify(result)



# ✅ Smart Suggestions via GPT-3.5
@app.route('/api/gpt/plan', methods=['POST'])
def gpt_plan():
    scores = request.json
    prompt = f"""
    A student has the following English skill levels out of 10:
    - Reading: {scores.get('reading', 0)}
    - Writing: {scores.get('writing', 0)}
    - Listening: {scores.get('listening', 0)}
    - Speaking: {scores.get('speaking', 0)}

    Based on this, suggest a personalized study plan for today in 5–6 bullet points.
    Make it helpful, specific, and motivational.
    """

    try:
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[{"role": "user", "content": prompt}]
        )
        return jsonify({"plan": response['choices'][0]['message']['content']})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(port=5000)
