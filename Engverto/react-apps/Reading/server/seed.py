from app import create_app, db
from app.models import Passage, Question

app = create_app()

with app.app_context():
    
    # ✅ Test Set 1
    passage1 = Passage(
        title="The Power of Reading",
        content="""
Reading is one of the most powerful tools we have to gain knowledge, improve our communication skills, and increase our empathy.
By engaging with stories and information, we expand our minds and see the world through the eyes of others.

In today’s digital age, the importance of reading is often overshadowed by fast content consumption.
However, those who read regularly are known to perform better academically and have stronger critical thinking skills.
        """,
        level="Intermediate"
    )
    db.session.add(passage1)
    db.session.commit()

    questions1 = [
        Question(
            passage_id=passage1.id,
            question_text="What are three benefits of reading mentioned in the passage?",
            correct_answer="Gain knowledge, improve communication, increase empathy",
            type="short",
            skill="comprehension"
        ),
        Question(
            passage_id=passage1.id,
            question_text="Why is reading often neglected in today’s digital world?",
            correct_answer="Because of fast content consumption",
            type="short",
            skill="analysis"
        ),
        Question(
            passage_id=passage1.id,
            question_text="Regular readers perform better academically and have ___.",
            correct_answer="stronger critical thinking skills",
            type="short",
            skill="inference"
        ),
    ]
    db.session.add_all(questions1)
    db.session.commit()

    print("✅ Successfully seeded Test Set 1")

    # ✅ Test Set 2
    passage2 = Passage(
        title="The Power of Music",
        level="Medium",
        content="""
Music is a universal language that has the ability to transcend cultural and linguistic barriers. Across the world, people turn to music for celebration, mourning, motivation, and relaxation. Scientific studies have shown that listening to music can stimulate brain activity, improve memory, and even relieve stress and anxiety. From ancient tribal drums to modern symphonies, music continues to be a vital part of the human experience.

In schools, educators use music to enhance learning. Songs are used to teach children the alphabet, historical events, and even mathematics. Therapists use music therapy to help patients cope with trauma or disability. Whether it’s a catchy pop tune or a calming instrumental piece, music resonates deeply with our emotions, shaping our memories and inspiring creativity.
        """
    )

    db.session.add(passage2)
    db.session.commit()

    questions2 = [
        Question(
            passage_id=passage2.id,
            question_text="What is one scientific benefit of listening to music?",
            correct_answer="It stimulates brain activity",
            type="short",
            skill="comprehension"
        ),
        Question(
            passage_id=passage2.id,
            question_text="Which of the following is NOT mentioned as a use of music?",
            correct_answer="Curing diseases",
            type="mcq",
            skill="inference",
            options="Celebration, Stress relief, Teaching, Curing diseases"
        ),
        Question(
            passage_id=passage2.id,
            question_text="How do educators use music in schools?",
            correct_answer="To enhance learning and teach concepts",
            type="short",
            skill="application"
        ),
        Question(
            passage_id=passage2.id,
            question_text="What kind of music is mentioned to calm emotions?",
            correct_answer="Instrumental music",
            type="mcq",
            skill="comprehension",
            options="Rock, Instrumental music, Pop, Jazz"
        ),
        Question(
            passage_id=passage2.id,
            question_text="Why is music called a universal language?",
            correct_answer="Because it transcends cultural and language barriers",
            type="short",
            skill="analysis"
        ),
    ]

    db.session.add_all(questions2)
    db.session.commit()

    print("✅ Successfully seeded Test Set 2")

# ✅ Test Set 3
    passage3 = Passage(
        title="Exploring the Ocean Depths",
        level="Advanced",
        content="""
        The ocean covers over 70% of Earth’s surface, yet much of it remains unexplored. Marine scientists use advanced technology like sonar, remotely operated vehicles (ROVs), and deep-sea submersibles to investigate these mysterious depths. They have discovered thousands of new species that survive in complete darkness and extreme pressure.

        Deep-sea ecosystems are vastly different from those near the surface. Sunlight does not penetrate these zones, so creatures have evolved unique adaptations such as bioluminescence to survive. The pressure can be hundreds of times higher than at sea level, making exploration a technical challenge.

        Protecting these deep-sea environments is becoming increasingly important. As industries look to exploit ocean resources, scientists stress the need for conservation. The balance of marine ecosystems is delicate, and disrupting it could have long-term effects on biodiversity and climate stability.
        """
    )
    db.session.add(passage3)
    db.session.commit()

    questions3 = [
        Question(
            passage_id=passage3.id,
            question_text="What tools do scientists use to explore the ocean depths?",
            correct_answer="Sonar, ROVs, and deep-sea submersibles",
            type="short",
            skill="comprehension"
        ),
        Question(
            passage_id=passage3.id,
            question_text="Why do some deep-sea creatures produce light?",
            correct_answer="To survive in darkness using bioluminescence",
            type="mcq",
            skill="application"
        ),
        Question(
            passage_id=passage3.id,
            question_text="What is a key threat to deep-sea environments?",
            correct_answer="Industrial exploitation of ocean resources",
            type="short",
            skill="inference"
        ),
        Question(
            passage_id=passage3.id,
            question_text="Which of the following is TRUE about deep-sea pressure?",
            correct_answer="It is much higher than at sea level",
            type="mcq",
            skill="knowledge"
        ),
        Question(
            passage_id=passage3.id,
            question_text="How can disrupting ocean ecosystems affect the planet?",
            correct_answer="It can impact biodiversity and climate stability",
            type="short",
            skill="analysis"
        )
    ]

    db.session.add_all(questions3)
    db.session.commit()
    print("✅ Successfully seeded Test Set 3")
