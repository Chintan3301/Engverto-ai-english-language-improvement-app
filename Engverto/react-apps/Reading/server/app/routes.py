from flask import Blueprint, request, jsonify
from . import db
from .models import Passage, Question, UserAnswer
import re
import uuid
import random
from collections import defaultdict
import os
from dotenv import load_dotenv
import openai

load_dotenv()
openai.api_key = os.getenv("OPENAI_API_KEY")

main = Blueprint('main', __name__)

# 🧼 Normalize text (remove punctuation, lowercase)
def normalize_text(text):
    return re.sub(r'[^\w\s]', '', text.lower()).strip()

# 🏠 API base check
@main.route('/')
def home():
    return jsonify({"message": "API is running!"})

# 📚 Get ONE random test set (passage + questions)
@main.route('/api/tests', methods=['GET'])
def get_tests():
    passages = Passage.query.all()
    if not passages:
        return jsonify({"message": "No passages found."}), 404

    passage = random.choice(passages)
    questions = Question.query.filter_by(passage_id=passage.id).all()

    return jsonify({
        "id": passage.id,
        "title": passage.title,
        "content": passage.content,
        "level": passage.level,
        "questions": [
            {
                "id": q.id,
                "question_text": q.question_text,
                "type": q.type,
                "skill": q.skill,
                "options": q.options.split(',') if q.type == 'mcq' and q.options else None
            } for q in questions
        ]
    })

# ✅ Handle test submission + AI feedback
@main.route('/api/submit', methods=['POST'])
def submit():
    data = request.json
    user_id = data.get("user_id")
    print("✅ Commit done. Answers saved to DB.")

    answers = data.get("answers", {})
    test_id = str(uuid.uuid4())

    if not user_id:
        return jsonify({"error": "User ID is required"}), 400

    results = []

    for q_id, user_answer in answers.items():
        question = Question.query.get(int(q_id))
        if not question:
            continue

        is_correct = normalize_text(user_answer) == normalize_text(question.correct_answer)
        score = 1 if is_correct else 0
        feedback = "Correct!" if is_correct else "Incorrect."

        # 🧠 Optional: Get AI feedback for incorrect answers
        ai_explanation = ""
        if not is_correct:
            try:
                response = openai.ChatCompletion.create(
                    model="gpt-3.5-turbo",
                    messages=[
                        {"role": "system", "content": "You're a helpful reading comprehension assistant."},
                        {"role": "user", "content": f"Question: {question.question_text}\nUser Answer: {user_answer}\nCorrect Answer: {question.correct_answer}\nPlease give friendly and helpful feedback."}
                    ],
                    max_tokens=120,
                    temperature=0.7
                )
                ai_explanation = response['choices'][0]['message']['content'].strip()
            except Exception as e:
                print("🔥 AI Error:", e)
                ai_explanation = "AI feedback could not be generated."

        # 📌 Save the user answer with test ID
        user_entry = UserAnswer(
            question_id=question.id,
            user_answer=user_answer,
            score=score,
            feedback=ai_explanation if ai_explanation else feedback,
            test_id=test_id,
            user_id=user_id
        )
        db.session.add(user_entry)

        results.append({
            "question_id": q_id,
            "score": score,
            "feedback": ai_explanation if ai_explanation else feedback
        })

        try:
            db.session.commit()
            print("✅ Answers committed to DB.")
        except Exception as e:
            db.session.rollback()
            print("❌ DB COMMIT FAILED:", e)

    

    return jsonify({
        "results": results,
        "total": len(results),
        "correct": sum(r["score"] for r in results),
        "test_id": test_id
    })

# 📊 Get user's submission history
@main.route('/api/history', methods=['GET'])
def history():
    answers = UserAnswer.query.order_by(UserAnswer.submitted_at.desc()).all()
    grouped = defaultdict(list)

    for ua in answers:
        grouped[ua.test_id].append(ua)

    history_data = []

    for test_id, answers in grouped.items():
        first = answers[0]
        total = len(answers)
        correct = sum(1 for a in answers if a.score)

        questions_data = []
        for ua in answers:
            question = Question.query.get(ua.question_id)
            passage = Passage.query.get(question.passage_id)
            questions_data.append({
                "question_text": question.question_text,
                "user_answer": ua.user_answer,
                "correct_answer": question.correct_answer,
                "score": ua.score,
                "feedback": ua.feedback
            })

        history_data.append({
            "test_id": test_id,
            "passage_title": passage.title,
            "submitted_at": first.submitted_at.strftime("%Y-%m-%d %H:%M"),
            "total": total,
            "correct": correct,
            "questions": questions_data
        })

    return jsonify(history_data)
