from flask import Blueprint, request, jsonify
from app.models import db, ListeningTest, ListeningQuestion, ListeningHistory
import uuid
from datetime import datetime

test_routes = Blueprint("tests", __name__)

# ✅ Get all tests
@test_routes.route("/tests", methods=["GET"])
def get_tests():
    tests = ListeningTest.query.all()
    return jsonify([
        {"id": test.id, "title": test.title, "level": test.level}
        for test in tests
    ])

# ✅ Get a specific test by ID
@test_routes.route("/tests/<test_id>", methods=["GET"])
def get_test(test_id):
    test = ListeningTest.query.get(test_id)
    if not test:
        return jsonify({"error": "Test not found"}), 404

    questions = ListeningQuestion.query.filter_by(test_id=test_id).all()
    return jsonify({
        "id": test.id,
        "title": test.title,
        "audio_url": test.audio_url,
        "transcript": test.transcript,
        "questions": [
            {
                "id": str(q.id),
                "question_type": q.question_type,
                "question_text": q.question_text,
                "options": q.options,
                "correct_answer": q.correct_answer
            } for q in questions
        ]
    })

# ✅ Submit user answers and calculate score
@test_routes.route("/tests/<test_id>/submit", methods=["POST"])
def submit_answers(test_id):
    data = request.json
    user_answers = data.get("answers", {})
    user_id = data.get("user_id")  # ✅ Grab user_id from frontend

    questions = ListeningQuestion.query.filter_by(test_id=test_id).all()
    test = ListeningTest.query.get(test_id)

    score = 0
    result_map = {}
    transcript_result = []

    for q in questions:
        user_input = user_answers.get(str(q.id), "").strip()
        correct_answer = q.correct_answer.strip()

        is_correct = user_input.lower() == correct_answer.lower()
        if is_correct:
            score += 1
        result_map[str(q.id)] = is_correct

        # Only for detailed feedback
        if q.question_type in ["fill_in_the_blank", "dictation"]:
            correct_words = correct_answer.split()
            user_words = user_input.split()

            comparison = []
            for i, word in enumerate(correct_words):
                user_word = user_words[i] if i < len(user_words) else ""
                comparison.append({
                    "word": word,
                    "correct": word.lower() == user_word.lower()
                })

            transcript_result.append({
                "question_id": str(q.id),
                "user_input": user_input,
                "comparison": comparison
            })

    # ✅ Save to Listening History only if user_id is provided
    if user_id:
        history = ListeningHistory(
            id=str(uuid.uuid4()),
            user_id=user_id,
            test_id=test.id,
            test_title=test.title,
            score=score,
            total=len(questions),
            timestamp=datetime.utcnow()
        )
        db.session.add(history)
        db.session.commit()

    return jsonify({
        "score": score,
        "total": len(questions),
        "results": result_map,
        "transcript_feedback": transcript_result
    })

# ✅ Get all history
@test_routes.route("/history", methods=["GET"])
def get_history():
    history = ListeningHistory.query.order_by(ListeningHistory.timestamp.desc()).all()
    return jsonify([
        {
            "id": str(h.id),
            "test_title": h.test_title,
            "score": h.score,
            "total": h.total,
            "timestamp": h.timestamp.strftime("%Y-%m-%d %H:%M:%S")
        }
        for h in history
    ])

# ✅ Delete a specific history record
@test_routes.route("/history/<history_id>", methods=["DELETE"])
def delete_history(history_id):
    record = ListeningHistory.query.get(history_id)
    if not record:
        return jsonify({"error": "Record not found"}), 404

    db.session.delete(record)
    db.session.commit()
    return jsonify({"message": "Record deleted"})
