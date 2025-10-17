# server/seed.py

from flask import Flask
from app.config import DATABASE_URI
from app.models import db, ListeningTest, ListeningQuestion
import uuid
from datetime import datetime, timezone

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)

with app.app_context():
    # ❌ Clear existing test/question data
    db.session.query(ListeningQuestion).delete()
    db.session.query(ListeningTest).delete()
    db.session.commit()

    # ✅ Add "A Friend"
    friend_id = str(uuid.uuid4())
    friend_test = ListeningTest(
        id=friend_id,
        title="A Friend",
        audio_url="http://localhost:5003/static/audio/a-friend.mp3",
        transcript=[
            "Who’s your best friend?",
            "It’s Jenny. She’s my best friend.",
            "What does she look like?",
            "She has shoulder-length brown hair. I just love her lovely smile.",
            "I first met her when we were in high school.",
            "I see her every day. We’re in the same class.",
            "She’s not only thoughtful but also very understanding. She’s always by my side to cheer me up whenever I’m in trouble.",
            "Yes, a lot. We both love shopping and playing sports.",
            "We usually do homework and read books together.",
            "Yes, but we seldom quarrel. When we do argue, afterwards we seem to understand more about each other.",
            "Yes, but she’s not a great cook.",
            "Yes, a lot. They always ask Jenny to come over for dinner.",
            "A good friend can make your life better in many ways. I don’t think anyone can stand loneliness."
        ],
        level="Beginner",
        created_at=datetime.now(timezone.utc)
    )
    db.session.add(friend_test)

    friend_questions = [
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=friend_id,
            question_type="multiple_choice",
            question_text="What color is Jenny’s hair?",
            options=["Blonde", "Black", "Brown", "Red"],
            correct_answer="Brown"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=friend_id,
            question_type="true_false",
            question_text="Jenny and the speaker met in university.",
            options=None,
            correct_answer="false"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=friend_id,
            question_type="fill_in_the_blank",
            question_text="The speaker and Jenny usually do ______ and read books together.",
            options=None,
            correct_answer="homework"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=friend_id,
            question_type="multiple_choice",
            question_text="How often does the speaker see Jenny?",
            options=["Every weekend", "Twice a week", "Every day", "Rarely"],
            correct_answer="Every day"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=friend_id,
            question_type="true_false",
            question_text="Jenny is a great cook.",
            options=None,
            correct_answer="false"
        ),
    ]

    db.session.add_all(friend_questions)

    # ✅ Add "Accident"
    accident_id = str(uuid.uuid4())
    accident_test = ListeningTest(
        id=accident_id,
        title="Accident",
        audio_url="http://localhost:5003/static/audio/accident.mp3",
        transcript=[
            "Have you ever been in any traffic accident?",
            "Yes, three years ago.",
            "I was hit by a car while crossing the road.",
            "I felt really terrible because of my injuries.",
            "The car driver, his family (inside the car), and me.",
            "I was walking, so I did not require any car repair services.",
            "I hurt my lower back just a little, so I didn’t call a lawyer.",
            "No, we didn’t want to get the police involved.",
            "No, the injury wasn’t really serious.",
            "Yes, I do. I always keep it in my purse.",
            "To protect themselves and others. The best ways are to wear a helmet, wait for traffic lights, and stay in the appropriate vehicle/pedestrian lanes."
        ],
        level="Beginner",
        created_at=datetime.now(timezone.utc)
    )
    db.session.add(accident_test)

    accident_questions = [
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=accident_id,
            question_type="multiple_choice",
            question_text="When did the accident happen?",
            options=["Last year", "Two years ago", "Three years ago", "Four years ago"],
            correct_answer="Three years ago"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=accident_id,
            question_type="fill_in_the_blank",
            question_text="The speaker was hit by a ______ while crossing the road.",
            options=None,
            correct_answer="car"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=accident_id,
            question_type="true_false",
            question_text="The speaker called a lawyer after the accident. True or False?",
            options=None,
            correct_answer="false"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=accident_id,
            question_type="true_false",
            question_text="The accident involved the speaker and a family in a car. True or False?",
            options=None,
            correct_answer="true"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=accident_id,
            question_type="multiple_choice",
            question_text="What did the speaker say is one way to obey traffic regulations?",
            options=["Drive fast", "Ignore traffic lights", "Wear a helmet", "Cross the road anywhere"],
            correct_answer="Wear a helmet"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=accident_id,
            question_type="true_false",
            question_text="The speaker was taken to the hospital. True or False?",
            options=None,
            correct_answer="false"
        ),
    ]

    db.session.add_all(accident_questions)

        # ✅ Add "Family"
    family_id = str(uuid.uuid4())
    family_test = ListeningTest(
        id=family_id,
        title="Family",
        audio_url="http://localhost:5003/static/audio/Family.mp3",
        transcript=[
            "How many people are there in your family?",
            "There are 5 people in my family: my father, mother, brother, sister, and me.",
            "We live in a house in the countryside.",
            "My father is a doctor. He works at the local hospital.",
            "She is 40 years old, 1 year younger than my father.",
            "Yes, I do. I have 1 elder brother, David, and 1 younger sister, Mary.",
            "No, I’m not. I’m the second child in my family.",
            "My father likes playing football and my mother likes cooking.",
            "Of course not. They always ask me to get home before 10 pm each night.",
            "Right now, no, but I used to.",
            "Yes, we do. My mom always prepares delicious meals for us."
        ],
        level="Intermediate",
        created_at=datetime.now(timezone.utc)
    )
    db.session.add(family_test)

    family_questions = [
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=family_id,
            question_type="multiple_choice",
            question_text="Where does the speaker’s family live?",
            options=["In a city apartment", "In a house in the countryside", "In a townhouse", "In a beach house"],
            correct_answer="In a house in the countryside"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=family_id,
            question_type="fill_in_the_blank",
            question_text="The speaker's father is a ______.",
            options=None,
            correct_answer="doctor"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=family_id,
            question_type="true_false",
            question_text="The speaker is the oldest child in the family. True or False?",
            options=None,
            correct_answer="False"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=family_id,
            question_type="true_false",
            question_text="The speaker’s mom enjoys cooking. True or False?",
            options=None,
            correct_answer="True"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=family_id,
            question_type="multiple_choice",
            question_text="What are the names of the speaker’s siblings?",
            options=["John and Lisa", "David and Mary", "Tom and Anna", "Jack and Emily"],
            correct_answer="David and Mary"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=family_id,
            question_type="true_false",
            question_text="The speaker currently lives with their parents. True or False?",
            options=None,
            correct_answer="False"
        ),
        ListeningQuestion(
            id=str(uuid.uuid4()),
            test_id=family_id,
            question_type="true_false",
            question_text="The speaker’s family usually has dinner together. True or False?",
            options=None,
            correct_answer="True"
        ),
    ]

    db.session.add_all(family_questions)


    db.session.commit()
    print("✅ Test 'A Friend' added successfully!")
    print("✅ Test 'Accident' added successfully!")
    print("✅ Test 'Family' added successfully!")

