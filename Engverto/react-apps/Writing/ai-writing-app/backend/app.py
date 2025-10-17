from flask import Flask, request, jsonify
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy

import openai
import json
import logging

# Setup logging
logging.basicConfig(level=logging.INFO)

# Initialize Flask app
app = Flask(__name__)
CORS(app)

# 🧠 OpenAI API Key
openai.api_key = "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"

# ✅ Database Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql://postgres:Asdfg%40123@localhost:5433/engverto_dash'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

# ✅ Database Model
class WritingFeedback(db.Model):
    __tablename__ = 'writing_feedback'

    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer) 
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

    created_at = db.Column(db.DateTime, server_default=db.func.now())

# ✅ Home route
@app.route('/')
def home():
    return "✅ AI Writing Feedback API running on port 5002!"

# ✅ Feedback Route
@app.route('/api/feedback', methods=['POST'])
def feedback():
    try:
        data = request.get_json()
        logging.info(f"Received data: {data}")

        text = data.get('text')
        writing_type = data.get('type')
        situation = data.get('situation', '')
        task = data.get('topic', '')
        prompt_text = data.get('prompt_text', '')

        prompt = f"""
You are an advanced English tutor assessing a student's writing. Return this JSON:

{{
  "scores": {{
    "content": {{ "relevance": 8, "depth": 7 }},
    "organization": {{ "paragraph_structure": 9, "coherence": 8 }},
    "grammar": {{ "tenses": 14, "agreement_punctuation": 13 }},
    "vocabulary": {{ "range": 9, "idioms": 7 }},
    "style_tone": {{ "audience": 8 }},
    "total": 83
  }},
  "comments": {{
    "grammar": "...",
    "vocabulary": "...",
    "structure": "...",
    "tone": "...",
    "rewrite": "Improved rewrite suggestion",
    "improve": "Full improved version"
  }},
  "links": []
}}

Now assess this writing:

Type: {writing_type}
Text: {text}
"""

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": "You are a helpful English tutor."},
                {"role": "user", "content": prompt}
            ],
            temperature=0.7,
            max_tokens=1500
        )

        reply = response['choices'][0]['message']['content']
        feedback = json.loads(reply)
        feedback.setdefault("links", [])
        feedback['type'] = writing_type

        # ✅ Save to DB
        new_feedback = WritingFeedback(
            user_id=1,  # Replace with dynamic user_id if needed
            writing_type=writing_type,
            situation=situation,
            task=task,
            prompt_text=prompt_text,
            user_writing=text,

            score_total=feedback['scores']['total'],
            score_content_relevance=feedback['scores']['content']['relevance'],
            score_content_depth=feedback['scores']['content']['depth'],
            score_organization_paragraphs=feedback['scores']['organization']['paragraph_structure'],
            score_organization_coherence=feedback['scores']['organization']['coherence'],
            score_grammar_tenses=feedback['scores']['grammar']['tenses'],
            score_grammar_agreement_punctuation=feedback['scores']['grammar']['agreement_punctuation'],
            score_vocab_range=feedback['scores']['vocabulary']['range'],
            score_vocab_idioms=feedback['scores']['vocabulary']['idioms'],
            score_style_audience=feedback['scores']['style_tone']['audience'],

            comment_grammar=feedback['comments']['grammar'],
            comment_vocabulary=feedback['comments']['vocabulary'],
            comment_structure=feedback['comments']['structure'],
            comment_tone=feedback['comments']['tone'],
            rewrite_suggestion=feedback['comments']['rewrite'],
            improved_version=feedback['comments']['improve']
        )

        db.session.add(new_feedback)
        db.session.commit()

        return jsonify(feedback)

    except Exception as e:
        logging.error(f"Feedback Error: {str(e)}")
        return jsonify({"error": str(e)}), 500

# ✅ Prompt Route
@app.route('/api/prompt', methods=['GET'])
def generate_prompt():
    try:
        system_message = "You are a prompt generator for ESL students. Create realistic writing scenarios."
        user_message = """
Generate a random writing prompt in this JSON format:

{
  "situation": "Describe a real-life context or reason.",
  "topic": "Clear writing instruction (letter, report, etc).",
  "type": "letter"  // or "report"
}

Make it practical, school or work-related.
"""

        response = openai.ChatCompletion.create(
            model="gpt-3.5-turbo",
            messages=[
                {"role": "system", "content": system_message},
                {"role": "user", "content": user_message}
            ],
            temperature=0.8,
            max_tokens=200
        )

        content = response['choices'][0]['message']['content']
        prompt_json = json.loads(content)
        return jsonify(prompt_json)

    except Exception as e:
        logging.error(f"Prompt Error: {str(e)}")
        return jsonify({"error": "Failed to generate prompt"}), 500

@app.route('/api/history', methods=['GET'])
def get_history():
      #from models import WritingFeedback# if you put the model in a separate file
    feedbacks = WritingFeedback.query.order_by(WritingFeedback.created_at.desc()).limit(50).all()
    results = []
    for fb in feedbacks:
        results.append({
            "id": fb.id,
            "timestamp": fb.created_at.strftime('%Y-%m-%d %H:%M:%S'),
            "type": fb.writing_type,
            "situation": fb.situation,
            "task": fb.task,
            "prompt": fb.prompt_text,
            "writing": fb.user_writing,
            "feedback": {
                "scores": {
                    "total": fb.score_total,
                    "content": {
                        "relevance": fb.score_content_relevance,
                        "depth": fb.score_content_depth
                    },
                    "organization": {
                        "paragraph_structure": fb.score_organization_paragraphs,
                        "coherence": fb.score_organization_coherence
                    },
                    "grammar": {
                        "tenses": fb.score_grammar_tenses,
                        "agreement_punctuation": fb.score_grammar_agreement_punctuation
                    },
                    "vocabulary": {
                        "range": fb.score_vocab_range,
                        "idioms": fb.score_vocab_idioms
                    },
                    "style_tone": {
                        "audience": fb.score_style_audience
                    }
                },
                "comments": {
                    "grammar": fb.comment_grammar,
                    "vocabulary": fb.comment_vocabulary,
                    "structure": fb.comment_structure,
                    "tone": fb.comment_tone,
                    "rewrite": fb.rewrite_suggestion,
                    "improve": fb.improved_version
                },
                "type": fb.writing_type
            }
        })
    return jsonify(results)

#  Start the server on port 5002
if __name__ == '__main__':
    app.run(debug=True, port=5002)



