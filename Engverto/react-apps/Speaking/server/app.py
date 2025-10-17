from flask import Flask, request, jsonify
from flask_cors import CORS
from dotenv import load_dotenv
import os
import psycopg2
import openai
import json
from datetime import datetime
import re

# Load environment variables from .env file
load_dotenv()

# Environment variables
DB_NAME = os.getenv("DB_NAME")
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")

OPENAI_API_KEY = os.getenv("OPENAI_API_KEY")

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# Set up OpenAI
openai.api_key = OPENAI_API_KEY

# Connect to PostgreSQL
try:
    conn = psycopg2.connect(
        dbname=DB_NAME,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port="5433"
    )

    print("✅ Connected to PostgreSQL")
except Exception as e:
    print("❌ PostgreSQL connection failed:", e)
    print("🔐 DB:", DB_NAME, DB_USER, DB_PASSWORD, DB_HOST)


# 🔁 Save speaking session to DB
def save_speaking_session(user_id, session_type, topic, conversation, feedback=None, fluency_score=None):
    try:
        cur = conn.cursor()
        cur.execute("""
            INSERT INTO speaking_sessions 
            (user_id, session_type, topic, timestamp, conversation, feedback, fluency_score)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            user_id,
            session_type,
            topic,
            datetime.now(),
            json.dumps(conversation),
            feedback,
            fluency_score
        ))
        conn.commit()
        cur.close()
        print("✅ Session saved to DB.")
    except Exception as e:
        print("❌ Error saving session to DB:", e)


# 🧠 GPT chat endpoint
@app.route('/chat', methods=['POST'])
def chat():
    try:
        data = request.get_json()
        user_input = data.get("text", "")
        print("🧠 User input received:", user_input)

        # Main GPT reply
        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": (
                    "You are Engverto, a friendly English conversation partner. "
                    "Correct grammar gently, respond naturally, and always ask a follow-up question."
                )},
                {"role": "user", "content": user_input}
            ]
        )

        reply = response['choices'][0]['message']['content']
        print("🤖 GPT response:", reply)

        return jsonify({'response': reply})

    except Exception as e:
        print("❌ GPT chat error:", e)
        return jsonify({'response': "Sorry, something went wrong."}), 500


# 💾 Save full feedback session to database
@app.route('/save-session', methods=['POST'])
def save_session():
    try:
        data = request.get_json()

        user_id = data.get('user_id', 1)  # Static for now
        session_type = data.get('session_type', 'conversation')
        topic = data.get('topic')  # Optional
        conversation = data.get('messages', [])
        feedback = json.dumps(data.get('feedback', {}))
        fluency_score = data.get('feedback', {}).get('overallScore')

        cur = conn.cursor()
        cur.execute("""
            INSERT INTO speaking_sessions 
            (user_id, session_type, topic, timestamp, conversation, feedback, fluency_score)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (
            user_id,
            session_type,
            topic,
            datetime.now(),
            json.dumps(conversation),
            feedback,
            fluency_score
        ))

        conn.commit()
        cur.close()

        print("✅ Feedback session saved.")
        return jsonify({"message": "Session saved successfully"}), 200

    except Exception as e:
        print("❌ Save session error:", e)
        return jsonify({"error": "Failed to save session"}), 500


# ✅ Root route for testing
@app.route('/')
def home():
    return "✅ Flask server is running on port 5004."


# 🚀 Run Flask on port 5004
if __name__ == "__main__":
    app.run(debug=True, port=5004)
