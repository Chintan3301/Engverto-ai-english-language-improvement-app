--
-- PostgreSQL database dump
--

-- Dumped from database version 16.8
-- Dumped by pg_dump version 17.4

-- Started on 2025-04-11 03:52:07

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 223 (class 1259 OID 24670)
-- Name: listening_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listening_history (
    id uuid NOT NULL,
    user_id integer,
    test_id uuid,
    test_title text,
    score integer,
    total integer,
    "timestamp" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.listening_history OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24658)
-- Name: listening_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listening_questions (
    id uuid NOT NULL,
    test_id uuid,
    question_type text,
    question_text text,
    options jsonb,
    correct_answer text
);


ALTER TABLE public.listening_questions OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 24650)
-- Name: listening_tests; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.listening_tests (
    id uuid NOT NULL,
    title text NOT NULL,
    audio_url text NOT NULL,
    transcript jsonb,
    level text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.listening_tests OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 24712)
-- Name: reading_answers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reading_answers (
    id integer NOT NULL,
    question_id integer,
    user_id integer,
    user_answer text,
    score integer,
    feedback text,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    test_id uuid
);


ALTER TABLE public.reading_answers OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24711)
-- Name: reading_answers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reading_answers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reading_answers_id_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 228
-- Name: reading_answers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reading_answers_id_seq OWNED BY public.reading_answers.id;


--
-- TOC entry 225 (class 1259 OID 24689)
-- Name: reading_passages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reading_passages (
    id integer NOT NULL,
    title character varying(100),
    content text,
    level character varying(50)
);


ALTER TABLE public.reading_passages OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 24688)
-- Name: reading_passages_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reading_passages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reading_passages_id_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 224
-- Name: reading_passages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reading_passages_id_seq OWNED BY public.reading_passages.id;


--
-- TOC entry 227 (class 1259 OID 24698)
-- Name: reading_questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reading_questions (
    id integer NOT NULL,
    passage_id integer,
    question_text text,
    correct_answer text,
    type character varying(20),
    skill character varying(50),
    options text
);


ALTER TABLE public.reading_questions OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 24697)
-- Name: reading_questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reading_questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reading_questions_id_seq OWNER TO postgres;

--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 226
-- Name: reading_questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reading_questions_id_seq OWNED BY public.reading_questions.id;


--
-- TOC entry 220 (class 1259 OID 24621)
-- Name: speaking_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.speaking_sessions (
    id integer NOT NULL,
    user_id integer,
    session_type text,
    topic text,
    "timestamp" timestamp without time zone DEFAULT now(),
    conversation jsonb,
    feedback text,
    fluency_score integer
);


ALTER TABLE public.speaking_sessions OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 24620)
-- Name: speaking_sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.speaking_sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.speaking_sessions_id_seq OWNER TO postgres;

--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 219
-- Name: speaking_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.speaking_sessions_id_seq OWNED BY public.speaking_sessions.id;


--
-- TOC entry 218 (class 1259 OID 24606)
-- Name: user_activity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_activity (
    id integer NOT NULL,
    user_id integer,
    module text NOT NULL,
    test_id integer,
    score integer NOT NULL,
    feedback text,
    submitted_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.user_activity OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 24605)
-- Name: user_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_activity_id_seq OWNER TO postgres;

--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_activity_id_seq OWNED BY public.user_activity.id;


--
-- TOC entry 216 (class 1259 OID 24597)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username text
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24596)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 231 (class 1259 OID 24733)
-- Name: writing_feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.writing_feedback (
    id integer NOT NULL,
    user_id integer,
    writing_type character varying(50),
    situation text,
    task text,
    prompt_text text,
    user_writing text,
    score_total integer,
    score_content_relevance integer,
    score_content_depth integer,
    score_organization_paragraphs integer,
    score_organization_coherence integer,
    score_grammar_tenses integer,
    score_grammar_agreement_punctuation integer,
    score_vocab_range integer,
    score_vocab_idioms integer,
    score_style_audience integer,
    comment_grammar text,
    comment_vocabulary text,
    comment_structure text,
    comment_tone text,
    rewrite_suggestion text,
    improved_version text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.writing_feedback OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24732)
-- Name: writing_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.writing_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.writing_feedback_id_seq OWNER TO postgres;

--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 230
-- Name: writing_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.writing_feedback_id_seq OWNED BY public.writing_feedback.id;


--
-- TOC entry 4786 (class 2604 OID 24715)
-- Name: reading_answers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_answers ALTER COLUMN id SET DEFAULT nextval('public.reading_answers_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 24692)
-- Name: reading_passages id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_passages ALTER COLUMN id SET DEFAULT nextval('public.reading_passages_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 24701)
-- Name: reading_questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_questions ALTER COLUMN id SET DEFAULT nextval('public.reading_questions_id_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 24624)
-- Name: speaking_sessions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speaking_sessions ALTER COLUMN id SET DEFAULT nextval('public.speaking_sessions_id_seq'::regclass);


--
-- TOC entry 4778 (class 2604 OID 24609)
-- Name: user_activity id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_activity ALTER COLUMN id SET DEFAULT nextval('public.user_activity_id_seq'::regclass);


--
-- TOC entry 4777 (class 2604 OID 24600)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 24736)
-- Name: writing_feedback id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writing_feedback ALTER COLUMN id SET DEFAULT nextval('public.writing_feedback_id_seq'::regclass);


--
-- TOC entry 4970 (class 0 OID 24670)
-- Dependencies: 223
-- Data for Name: listening_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listening_history (id, user_id, test_id, test_title, score, total, "timestamp") FROM stdin;
f2a90621-4fbb-4fa5-ba18-59c2afc4788e	\N	6216236a-398c-443c-afe9-bc69f3ecc8a4	Accident	0	6	2025-04-10 01:57:44.251232
eba8079c-33e2-416f-88bd-40104dcb0f54	\N	186f53bb-669d-4568-95be-4af27e5c7730	A Friend	4	5	2025-04-10 14:49:43.011829
3472cf1d-cb3e-4637-8d70-077534040a92	1	6216236a-398c-443c-afe9-bc69f3ecc8a4	Accident	2	6	2025-04-11 01:18:20.626262
53e6a37d-cb72-4e5e-9101-3d781836f196	1	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	Family	2	7	2025-04-11 02:18:37.871858
\.


--
-- TOC entry 4969 (class 0 OID 24658)
-- Dependencies: 222
-- Data for Name: listening_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listening_questions (id, test_id, question_type, question_text, options, correct_answer) FROM stdin;
1b21e795-0e41-4bd0-9bd5-1e6ad3e2b9f9	186f53bb-669d-4568-95be-4af27e5c7730	multiple_choice	What color is Jenny’s hair?	["Blonde", "Black", "Brown", "Red"]	Brown
1dda8fa2-fd39-4b59-bff7-6e00f97a6bf5	186f53bb-669d-4568-95be-4af27e5c7730	true_false	Jenny and the speaker met in university.	null	false
82447a78-4f1a-4c5e-beda-92cfb2273b62	186f53bb-669d-4568-95be-4af27e5c7730	fill_in_the_blank	The speaker and Jenny usually do ______ and read books together.	null	homework
b5740fe2-14fc-44bc-82d3-5a5e7522f86b	186f53bb-669d-4568-95be-4af27e5c7730	multiple_choice	How often does the speaker see Jenny?	["Every weekend", "Twice a week", "Every day", "Rarely"]	Every day
75f7e8bb-d8da-4b15-afb2-b4318ebcc3bc	186f53bb-669d-4568-95be-4af27e5c7730	true_false	Jenny is a great cook.	null	false
2fc4a638-d989-48d8-a18d-a97e10c7c61c	6216236a-398c-443c-afe9-bc69f3ecc8a4	multiple_choice	When did the accident happen?	["Last year", "Two years ago", "Three years ago", "Four years ago"]	Three years ago
191920d5-94db-4222-baad-696eb0d6dfcd	6216236a-398c-443c-afe9-bc69f3ecc8a4	fill_in_the_blank	The speaker was hit by a ______ while crossing the road.	null	car
1eabb004-293f-42aa-8b4e-20db3b44f10f	6216236a-398c-443c-afe9-bc69f3ecc8a4	true_false	The speaker called a lawyer after the accident. True or False?	null	false
2d7c059c-9f14-46d1-898a-26eefe127a06	6216236a-398c-443c-afe9-bc69f3ecc8a4	true_false	The accident involved the speaker and a family in a car. True or False?	null	true
f875134e-c530-43e4-8048-1b771ae37e03	6216236a-398c-443c-afe9-bc69f3ecc8a4	multiple_choice	What did the speaker say is one way to obey traffic regulations?	["Drive fast", "Ignore traffic lights", "Wear a helmet", "Cross the road anywhere"]	Wear a helmet
09244836-66f4-4784-99f6-c782aafd80c5	6216236a-398c-443c-afe9-bc69f3ecc8a4	true_false	The speaker was taken to the hospital. True or False?	null	false
d790d39c-cb99-47e7-a438-dbad5e4b4bff	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	multiple_choice	Where does the speaker’s family live?	["In a city apartment", "In a house in the countryside", "In a townhouse", "In a beach house"]	In a house in the countryside
09cf76b8-94ee-49a2-8254-9b6b4912e369	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	fill_in_the_blank	The speaker's father is a ______.	null	doctor
6e6192fa-7185-4ac1-b4d2-c2fc25bc3fd0	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	true_false	The speaker is the oldest child in the family. True or False?	null	False
455cbfe4-23dd-4451-9f1b-6ca6137de76b	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	true_false	The speaker’s mom enjoys cooking. True or False?	null	True
278f73bf-e2f0-4833-b749-df82c55d0e6d	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	multiple_choice	What are the names of the speaker’s siblings?	["John and Lisa", "David and Mary", "Tom and Anna", "Jack and Emily"]	David and Mary
494e07ac-1693-4a0a-996e-b0a0dd6bad2f	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	true_false	The speaker currently lives with their parents. True or False?	null	False
1fa188ce-c7fa-4ff1-b9f3-64ce50eebc47	a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	true_false	The speaker’s family usually has dinner together. True or False?	null	True
\.


--
-- TOC entry 4968 (class 0 OID 24650)
-- Dependencies: 221
-- Data for Name: listening_tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.listening_tests (id, title, audio_url, transcript, level, created_at) FROM stdin;
186f53bb-669d-4568-95be-4af27e5c7730	A Friend	http://localhost:5003/static/audio/a-friend.mp3	["Who’s your best friend?", "It’s Jenny. She’s my best friend.", "What does she look like?", "She has shoulder-length brown hair. I just love her lovely smile.", "I first met her when we were in high school.", "I see her every day. We’re in the same class.", "She’s not only thoughtful but also very understanding. She’s always by my side to cheer me up whenever I’m in trouble.", "Yes, a lot. We both love shopping and playing sports.", "We usually do homework and read books together.", "Yes, but we seldom quarrel. When we do argue, afterwards we seem to understand more about each other.", "Yes, but she’s not a great cook.", "Yes, a lot. They always ask Jenny to come over for dinner.", "A good friend can make your life better in many ways. I don’t think anyone can stand loneliness."]	Beginner	2025-04-10 02:57:09.66425
6216236a-398c-443c-afe9-bc69f3ecc8a4	Accident	http://localhost:5003/static/audio/accident.mp3	["Have you ever been in any traffic accident?", "Yes, three years ago.", "I was hit by a car while crossing the road.", "I felt really terrible because of my injuries.", "The car driver, his family (inside the car), and me.", "I was walking, so I did not require any car repair services.", "I hurt my lower back just a little, so I didn’t call a lawyer.", "No, we didn’t want to get the police involved.", "No, the injury wasn’t really serious.", "Yes, I do. I always keep it in my purse.", "To protect themselves and others. The best ways are to wear a helmet, wait for traffic lights, and stay in the appropriate vehicle/pedestrian lanes."]	Beginner	2025-04-10 02:57:09.664763
a1f45e63-1be7-46ea-aff7-aa9cdb5ff1b9	Family	http://localhost:5003/static/audio/Family.mp3	["How many people are there in your family?", "There are 5 people in my family: my father, mother, brother, sister, and me.", "We live in a house in the countryside.", "My father is a doctor. He works at the local hospital.", "She is 40 years old, 1 year younger than my father.", "Yes, I do. I have 1 elder brother, David, and 1 younger sister, Mary.", "No, I’m not. I’m the second child in my family.", "My father likes playing football and my mother likes cooking.", "Of course not. They always ask me to get home before 10 pm each night.", "Right now, no, but I used to.", "Yes, we do. My mom always prepares delicious meals for us."]	Intermediate	2025-04-10 02:57:09.664963
\.


--
-- TOC entry 4976 (class 0 OID 24712)
-- Dependencies: 229
-- Data for Name: reading_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reading_answers (id, question_id, user_id, user_answer, score, feedback, submitted_at, test_id) FROM stdin;
1	25	\N	ssd	0	Your answer is partially correct as sonar is indeed a tool used by scientists to explore the ocean depths. However, ROVs (Remotely Operated Vehicles) and deep-sea submersibles are also commonly used tools for ocean exploration. These vehicles allow scientists to remotely navigate and collect data from the deep sea, where human divers cannot go.	2025-04-10 04:36:53.325781	f01aa0b8-4a5f-45aa-82ef-0f999cedfce8
2	26	\N	sddd	0	Good effort, but your answer is not complete. Deep-sea creatures produce light through bioluminescence to help them survive in the darkness of the deep ocean by attracting prey, confusing predators, communication, and camouflage. Try to include more details in your response to provide a more comprehensive answer.	2025-04-10 04:36:53.325781	f01aa0b8-4a5f-45aa-82ef-0f999cedfce8
3	27	\N	sdd	0	Your answer is not correct. The key threat to deep-sea environments is the industrial exploitation of ocean resources, such as deep-sea mining, fishing, and energy extraction. This can lead to habitat destruction, species extinction, and disruption of deep-sea ecosystems. It's important to be aware of these threats to protect the fragile deep-sea environment. If you have any more questions or need further clarification, feel free to ask.	2025-04-10 04:36:53.325781	f01aa0b8-4a5f-45aa-82ef-0f999cedfce8
4	28	\N	sdd	0	Your answer "sdd" is incorrect. The correct answer is: "It is much higher than at sea level." Deep-sea pressure is indeed much higher than at sea level due to the weight of the water above pushing down on the depths of the ocean.	2025-04-10 04:36:53.325781	f01aa0b8-4a5f-45aa-82ef-0f999cedfce8
5	29	\N	sdd	0	Feedback: Your answer is not clear and does not fully address the question. It would be helpful to provide a more detailed response that explains how disrupting ocean ecosystems can impact biodiversity and climate stability on the planet.	2025-04-10 04:36:53.325781	f01aa0b8-4a5f-45aa-82ef-0f999cedfce8
6	20	\N	sdd	0	Your answer does not directly address the question about the scientific benefit of listening to music. In the context of brain activity, it would be more accurate to say that listening to music stimulates brain activity by engaging various regions of the brain involved in processing sound, language, memory, and emotion. Try to provide a more focused and relevant response next time.	2025-04-10 05:13:43.627696	ce3ce28e-643d-41be-adf8-54e274ddc8a1
7	21	\N	Curing diseases	1	Correct!	2025-04-10 05:13:43.627696	ce3ce28e-643d-41be-adf8-54e274ddc8a1
8	22	\N	dff	0	Your answer is not quite complete. Educators use music in schools not only to enhance learning and teach concepts, but also to improve memory retention, develop creativity, promote emotional expression, and provide a well-rounded education. Try to expand your answer to include these additional points.	2025-04-10 05:13:43.627696	ce3ce28e-643d-41be-adf8-54e274ddc8a1
9	23	\N	Instrumental music	1	Correct!	2025-04-10 05:13:43.627696	ce3ce28e-643d-41be-adf8-54e274ddc8a1
10	24	\N	sdd	0	Your answer is not accurate. The correct explanation for why music is called a universal language is because it has the ability to transcend cultural and language barriers, allowing people from different backgrounds to connect and communicate through the emotions and feelings conveyed by music. Try to provide a more detailed and precise response next time.	2025-04-10 05:13:43.627696	ce3ce28e-643d-41be-adf8-54e274ddc8a1
11	20	\N	fssd	0	Your answer does not address the question asked. The correct answer is that one scientific benefit of listening to music is that it stimulates brain activity. Make sure to provide relevant and accurate responses to the question being asked.	2025-04-10 14:52:16.005006	900c79dc-926e-4847-8e1c-664ff9a3f74e
12	21	\N	Curing diseases	1	Correct!	2025-04-10 14:52:16.005006	900c79dc-926e-4847-8e1c-664ff9a3f74e
13	22	\N	sdfd	0	Your answer is not specific and lacks detail. It would be helpful to provide more information on how educators use music in schools to enhance learning and teach various concepts. This could include examples of how music is integrated into different subject areas, the benefits of using music as a teaching tool, and the impact it can have on student engagement and understanding.	2025-04-10 14:52:16.005006	900c79dc-926e-4847-8e1c-664ff9a3f74e
14	23	\N	Instrumental music	1	Correct!	2025-04-10 14:52:16.005006	900c79dc-926e-4847-8e1c-664ff9a3f74e
15	24	\N	ref	0	Your answer is incorrect. The correct answer is: Music is called a universal language because it transcends cultural and language barriers, allowing people from different backgrounds to connect and communicate through the emotions and feelings it evokes. It serves as a powerful form of expression that can be understood and appreciated by individuals worldwide, regardless of their native language or cultural background.	2025-04-10 14:52:16.005006	900c79dc-926e-4847-8e1c-664ff9a3f74e
16	25	1	ds	0	Your answer is partially correct as it mentions "sonar," which is a tool used by scientists to explore the ocean depths. However, the complete list of tools commonly used includes sonar, remotely operated vehicles (ROVs), and deep-sea submersibles. These tools work together to help scientists study and explore the mysteries of the deep ocean.	2025-04-10 15:03:43.163601	d2bb73b1-3009-4ae0-a2ac-14ea2040b2c7
17	26	1	sads	0	Your answer is incorrect as it does not provide a detailed explanation. The correct response would include the term "bioluminescence" and explain how deep-sea creatures use light production to survive in the dark depths of the ocean. Try to provide more specific information in your answers to demonstrate a deeper understanding of the topic.	2025-04-10 15:03:43.163601	d2bb73b1-3009-4ae0-a2ac-14ea2040b2c7
18	27	1	sdas	0	Your answer is not correct. The key threat to deep-sea environments is industrial exploitation of ocean resources, such as deep-sea mining, overfishing, and pollution. It's important to pay attention to the details of the question and provide accurate responses.	2025-04-10 15:03:43.163601	d2bb73b1-3009-4ae0-a2ac-14ea2040b2c7
19	28	1	sas	0	Your answer, "sas," is not relevant to the question about deep-sea pressure. The correct answer is that deep-sea pressure is much higher than at sea level. This indicates that the pressure increases the deeper you go into the ocean. If you have any more questions or need further clarification, feel free to ask.	2025-04-10 15:03:43.163601	d2bb73b1-3009-4ae0-a2ac-14ea2040b2c7
20	29	1	sdas	0	It seems like there was a misunderstanding in your response. The correct answer is that disrupting ocean ecosystems can impact biodiversity and climate stability. It's important to provide a clear and accurate response when answering questions related to environmental impacts. If you have any more questions or need further clarification, feel free to ask.	2025-04-10 15:03:43.163601	d2bb73b1-3009-4ae0-a2ac-14ea2040b2c7
21	20	1	kjcsjkzxcbjz	0	It looks like your answer is not relevant to the question asked. A correct response would provide information related to the scientific benefits of listening to music, such as how it can stimulate brain activity, improve cognitive function, or enhance mood. Make sure to focus on answering the question accurately and providing relevant information.	2025-04-10 15:16:39.812918	c490eafa-2b03-4e25-9939-d3c531290338
22	21	1	Curing diseases	1	Correct!	2025-04-10 15:16:39.812918	c490eafa-2b03-4e25-9939-d3c531290338
23	22	1	sdkjsbdfj	0	Your answer does not provide a specific response to the question. It is important to provide relevant information that addresses how educators use music in schools, such as to enhance learning and teach concepts. Try to be more specific in your responses to demonstrate understanding.	2025-04-10 15:16:39.812918	c490eafa-2b03-4e25-9939-d3c531290338
24	23	1	Instrumental music	1	Correct!	2025-04-10 15:16:39.812918	c490eafa-2b03-4e25-9939-d3c531290338
25	24	1	transcend cultural and linguistic barriers	0	Your answer is very close to the correct answer. You accurately captured the essence of why music is considered a universal language. Just a small adjustment in wording to match the original answer would make it perfect. Keep up the good work!	2025-04-10 15:16:39.812918	c490eafa-2b03-4e25-9939-d3c531290338
26	17	1	gain knowledge improve communication skills increase our empathy	0	Great job identifying three benefits of reading from the passage! You correctly mentioned gaining knowledge, improving communication skills, and increasing empathy. Keep up the good work in extracting key points from the text!	2025-04-10 15:26:58.052088	060ba11f-00d8-484e-84ed-f37d5c148a89
27	18	1	gain knowledge improve communication skills increase our empathy	0	Thank you for your response! It's great that you see the benefits of reading for gaining knowledge, improving communication skills, and increasing empathy. In today's digital world, with fast content consumption through various media, traditional reading is sometimes neglected. By being aware of this trend, we can make a conscious effort to prioritize reading and its many benefits in our daily lives. Keep up the good work in recognizing the value of reading!	2025-04-10 15:26:58.052088	060ba11f-00d8-484e-84ed-f37d5c148a89
28	19	1	stronger critical thinking skills	1	Correct!	2025-04-10 15:26:58.052088	060ba11f-00d8-484e-84ed-f37d5c148a89
29	17	1	sd	0	It looks like you missed providing the benefits of reading mentioned in the passage. Remember to thoroughly read the text to identify key points and use that information to answer questions accurately. Keep practicing, and you'll improve your reading comprehension skills! If you have any questions or need further assistance, feel free to ask.	2025-04-10 15:37:15.992098	b4ea5e8b-74f5-466f-9b42-efab1f739492
30	18	1	fsdf	0	It seems like you may have made a typo in your response. The correct answer is that reading is often neglected in today's digital world because of fast content consumption. It's common for people to prefer quick and easily digestible information online, which can lead to a lack of focus on more in-depth reading. If you have any other questions or need further clarification, feel free to ask!	2025-04-10 15:37:17.389325	b4ea5e8b-74f5-466f-9b42-efab1f739492
31	19	1	stronger critical thinking skills	1	Correct!	2025-04-10 15:37:18.858937	b4ea5e8b-74f5-466f-9b42-efab1f739492
32	20	1	gh	0	Great effort! One scientific benefit of listening to music is that it stimulates brain activity. Keep up the good work! If you have any more questions, feel free to ask.	2025-04-10 23:37:03.753553	eb8c2ab1-a53e-470f-b06e-642fa9e66983
33	21	1	Curing diseases	1	Correct!	2025-04-10 23:37:05.152648	eb8c2ab1-a53e-470f-b06e-642fa9e66983
34	22	1	mm	0	It sounds like you might be unsure about how educators use music in schools. Educators use music as a tool to enhance learning and teach various concepts to students. By incorporating music into lessons, teachers can engage students, promote creativity, and help them better understand and remember the material. If you have any more questions or need further clarification, feel free to ask!	2025-04-10 23:37:05.15643	eb8c2ab1-a53e-470f-b06e-642fa9e66983
35	23	1	Instrumental music	1	Correct!	2025-04-10 23:37:06.211728	eb8c2ab1-a53e-470f-b06e-642fa9e66983
36	24	1	mmb	0	It seems like you may have misunderstood the question or had difficulty providing a complete answer. Music is called a universal language because it has the ability to connect people from different backgrounds and cultures through shared emotions and experiences. It transcends barriers such as language and culture, allowing people to communicate and connect on a deeper level. I hope this explanation helps clarify the concept for you! If you have any more questions, feel free to ask.	2025-04-10 23:37:06.215465	eb8c2ab1-a53e-470f-b06e-642fa9e66983
37	25	1	dsfd	0	It looks like you may have made a mistake in your response. Scientists use tools such as sonar, ROVs (remotely operated vehicles), and deep-sea submersibles to explore the ocean depths. Sonar helps with mapping the ocean floor, while ROVs and submersibles allow scientists to physically explore and collect data from the deep ocean. Feel free to ask if you have any other questions or need further clarification!	2025-04-11 02:14:01.309693	3799bee4-1ec6-4eac-a49c-6728b780947e
38	26	1	sdfds	0	It looks like you were trying to answer the question, but your response needs a bit more clarity. Deep-sea creatures produce light through a process called bioluminescence to help them survive in the darkness of the deep ocean. Keep up the good work! If you have any more questions or need further clarification, feel free to ask.	2025-04-11 02:14:03.110432	3799bee4-1ec6-4eac-a49c-6728b780947e
39	27	1	sdf	0	It seems like you may have misunderstood the question. The key threat to deep-sea environments is the industrial exploitation of ocean resources, such as deep-sea mining and bottom trawling. Feel free to ask if you have any more questions or need further clarification!	2025-04-11 02:14:04.143657	3799bee4-1ec6-4eac-a49c-6728b780947e
40	28	1	True	0	Great job! You correctly identified that the true statement about deep-sea pressure is that it is much higher than at sea level. Keep up the good work with your reading comprehension skills! If you have any more questions or need further assistance, feel free to ask.	2025-04-11 02:14:05.12735	3799bee4-1ec6-4eac-a49c-6728b780947e
41	29	1	Ture	0	Great effort! Disrupting ocean ecosystems can indeed have significant consequences for the planet. By impacting biodiversity and climate stability, it can lead to a range of negative effects on both marine and terrestrial environments. Keep up the good work in learning about these important environmental issues! If you have any more questions or need further clarification, feel free to ask.	2025-04-11 02:14:06.070122	3799bee4-1ec6-4eac-a49c-6728b780947e
42	20	1	rtrr	0	Great effort! One scientific benefit of listening to music is that it stimulates brain activity. Keep up the good work! If you have any more questions or need further assistance, feel free to ask.	2025-04-11 03:15:01.097874	58bd56cb-c842-45af-8ca1-a5392dee00f5
43	21	1	Curing diseases	1	Correct!	2025-04-11 03:15:02.436254	58bd56cb-c842-45af-8ca1-a5392dee00f5
44	22	1	rtrte	0	It seems like you may have misunderstood the question. Educators use music in schools to enhance learning and teach concepts. Feel free to ask if you have any more questions or need further clarification!	2025-04-11 03:15:02.440279	58bd56cb-c842-45af-8ca1-a5392dee00f5
45	23	1	Instrumental music	1	Correct!	2025-04-11 03:15:03.289754	58bd56cb-c842-45af-8ca1-a5392dee00f5
46	24	1	errtrt	0	It seems like you may have misunderstood the question. Music is often referred to as a universal language because it can be understood and appreciated by people from different cultures and backgrounds, even if they do not speak the same language. Keep practicing and you will improve your understanding of the topic!	2025-04-11 03:15:03.29408	58bd56cb-c842-45af-8ca1-a5392dee00f5
\.


--
-- TOC entry 4972 (class 0 OID 24689)
-- Dependencies: 225
-- Data for Name: reading_passages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reading_passages (id, title, content, level) FROM stdin;
6	The Power of Reading	\nReading is one of the most powerful tools we have to gain knowledge, improve our communication skills, and increase our empathy.\nBy engaging with stories and information, we expand our minds and see the world through the eyes of others.\n\nIn today’s digital age, the importance of reading is often overshadowed by fast content consumption.\nHowever, those who read regularly are known to perform better academically and have stronger critical thinking skills.\n        	Intermediate
7	The Power of Music	\nMusic is a universal language that has the ability to transcend cultural and linguistic barriers. Across the world, people turn to music for celebration, mourning, motivation, and relaxation. Scientific studies have shown that listening to music can stimulate brain activity, improve memory, and even relieve stress and anxiety. From ancient tribal drums to modern symphonies, music continues to be a vital part of the human experience.\n\nIn schools, educators use music to enhance learning. Songs are used to teach children the alphabet, historical events, and even mathematics. Therapists use music therapy to help patients cope with trauma or disability. Whether it’s a catchy pop tune or a calming instrumental piece, music resonates deeply with our emotions, shaping our memories and inspiring creativity.\n        	Medium
8	Exploring the Ocean Depths	\n        The ocean covers over 70% of Earth’s surface, yet much of it remains unexplored. Marine scientists use advanced technology like sonar, remotely operated vehicles (ROVs), and deep-sea submersibles to investigate these mysterious depths. They have discovered thousands of new species that survive in complete darkness and extreme pressure.\n\n        Deep-sea ecosystems are vastly different from those near the surface. Sunlight does not penetrate these zones, so creatures have evolved unique adaptations such as bioluminescence to survive. The pressure can be hundreds of times higher than at sea level, making exploration a technical challenge.\n\n        Protecting these deep-sea environments is becoming increasingly important. As industries look to exploit ocean resources, scientists stress the need for conservation. The balance of marine ecosystems is delicate, and disrupting it could have long-term effects on biodiversity and climate stability.\n        	Advanced
\.


--
-- TOC entry 4974 (class 0 OID 24698)
-- Dependencies: 227
-- Data for Name: reading_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reading_questions (id, passage_id, question_text, correct_answer, type, skill, options) FROM stdin;
17	6	What are three benefits of reading mentioned in the passage?	Gain knowledge, improve communication, increase empathy	short	comprehension	\N
18	6	Why is reading often neglected in today’s digital world?	Because of fast content consumption	short	analysis	\N
19	6	Regular readers perform better academically and have ___.	stronger critical thinking skills	short	inference	\N
20	7	What is one scientific benefit of listening to music?	It stimulates brain activity	short	comprehension	\N
21	7	Which of the following is NOT mentioned as a use of music?	Curing diseases	mcq	inference	Celebration, Stress relief, Teaching, Curing diseases
22	7	How do educators use music in schools?	To enhance learning and teach concepts	short	application	\N
23	7	What kind of music is mentioned to calm emotions?	Instrumental music	mcq	comprehension	Rock, Instrumental music, Pop, Jazz
24	7	Why is music called a universal language?	Because it transcends cultural and language barriers	short	analysis	\N
25	8	What tools do scientists use to explore the ocean depths?	Sonar, ROVs, and deep-sea submersibles	short	comprehension	\N
26	8	Why do some deep-sea creatures produce light?	To survive in darkness using bioluminescence	mcq	application	\N
27	8	What is a key threat to deep-sea environments?	Industrial exploitation of ocean resources	short	inference	\N
28	8	Which of the following is TRUE about deep-sea pressure?	It is much higher than at sea level	mcq	knowledge	\N
29	8	How can disrupting ocean ecosystems affect the planet?	It can impact biodiversity and climate stability	short	analysis	\N
\.


--
-- TOC entry 4967 (class 0 OID 24621)
-- Dependencies: 220
-- Data for Name: speaking_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.speaking_sessions (id, user_id, session_type, topic, "timestamp", conversation, feedback, fluency_score) FROM stdin;
1	1	conversation	\N	2025-04-10 07:09:57.119677	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744265394921}]	{"grammar": {"score": 20, "strengths": ["Transcript too short to evaluate."], "improvements": ["Not enough sentence structure detected.", "Use complete thoughts when speaking.", "Try to form proper subject-verb combinations."]}, "fluency": {"score": 25, "strengths": ["Transcript was processed successfully."], "improvements": ["Fluency could not be assessed from short input.", "More extended speaking is needed.", "Avoid long pauses and fillers."]}, "vocabulary": {"score": 22, "strengths": ["Transcript used very basic vocabulary."], "improvements": ["Not enough variety to analyze.", "Try using more descriptive words.", "Include real-world examples."]}, "overallScore": 22, "summary": "The response was too short or unclear to evaluate properly. Try speaking in full sentences for at least 20\\u201330 seconds."}	22
2	1	conversation	\N	2025-04-10 07:10:41.793561	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744265409782}, {"role": "user", "content": "hi I want to talk about porn world", "timestamp": 1744265420702}, {"role": "assistant", "content": "I'm sorry, but I'm here to have positive and respectful conversations. Is there another topic you would like to discuss?", "timestamp": 1744265421313}, {"role": "user", "content": "I said I would like to talk about football", "timestamp": 1744265436117}, {"role": "assistant", "content": "Of course! Football is a popular sport. Do you have a favorite team or player?", "timestamp": 1744265436649}]	{"grammar": {"score": 65, "strengths": ["Correct verb tense usage", "Subject-verb agreement is generally accurate", "Simple sentence structure is clear"], "improvements": ["Punctuation needed after 'hi'", "Incomplete sentence ('porn world' is not a complete thought)", "Lack of conjunction to connect ideas"]}, "fluency": {"score": 60, "strengths": ["Clear pronunciation", "Steady speaking pace", "Limited use of filler words"], "improvements": ["Inconsistent topic presentation", "Hesitation in switching topics", "Repetition of the word 'talk'"]}, "vocabulary": {"score": 70, "strengths": ["Appropriate use of vocabulary in context", "Clear communication of desired topic ('football')", "Basic idiomatic expression usage"], "improvements": ["Limited range of vocabulary", "Confusion between 'porn world' and 'football' topics", "Lack of variety in word choice"]}, "overallScore": 65, "suggestions": "To improve, focus on organizing thoughts more cohesively and expanding vocabulary to enhance expression."}	65
3	1	conversation	\N	2025-04-10 23:55:18.575263	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744325715579}]	{"grammar": {"score": 20, "strengths": ["Transcript too short to evaluate."], "improvements": ["Not enough sentence structure detected.", "Use complete thoughts when speaking.", "Try to form proper subject-verb combinations."]}, "fluency": {"score": 25, "strengths": ["Transcript was processed successfully."], "improvements": ["Fluency could not be assessed from short input.", "More extended speaking is needed.", "Avoid long pauses and fillers."]}, "vocabulary": {"score": 22, "strengths": ["Transcript used very basic vocabulary."], "improvements": ["Not enough variety to analyze.", "Try using more descriptive words.", "Include real-world examples."]}, "overallScore": 22, "summary": "The response was too short or unclear to evaluate properly. Try speaking in full sentences for at least 20\\u201330 seconds."}	22
4	1	conversation	\N	2025-04-11 02:19:40.555471	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744334375435}]	{"grammar": {"score": 20, "strengths": ["Transcript too short to evaluate."], "improvements": ["Not enough sentence structure detected.", "Use complete thoughts when speaking.", "Try to form proper subject-verb combinations."]}, "fluency": {"score": 25, "strengths": ["Transcript was processed successfully."], "improvements": ["Fluency could not be assessed from short input.", "More extended speaking is needed.", "Avoid long pauses and fillers."]}, "vocabulary": {"score": 22, "strengths": ["Transcript used very basic vocabulary."], "improvements": ["Not enough variety to analyze.", "Try using more descriptive words.", "Include real-world examples."]}, "overallScore": 22, "summary": "The response was too short or unclear to evaluate properly. Try speaking in full sentences for at least 20\\u201330 seconds."}	22
5	1	conversation	\N	2025-04-11 02:20:12.592432	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744334385840}, {"role": "user", "content": "hello my name is chintan gadia today I would like to talk about football", "timestamp": 1744334400652}, {"role": "assistant", "content": "Hi Chintan! Sure, football is a great topic. What would you like to discuss about football?", "timestamp": 1744334401494}]	{"grammar": {"score": 50, "strengths": ["Clear subject-verb agreement", "Correct verb tense usage", "First word capitalized"], "improvements": ["Incomplete sentence", "Missing punctuation at the end", "Lacks variety in sentence structure"]}, "fluency": {"score": 50, "strengths": ["Clear pronunciation", "Steady pace", "No use of filler words"], "improvements": ["Short utterance", "Lack of elaboration/detail", "Unnatural pauses"]}, "vocabulary": {"score": 50, "strengths": ["Clear use of common words", "Relevant topic choice", "Basic introduction skill"], "improvements": ["Limited vocabulary range", "No idiomatic expressions", "Lacks descriptive words"]}, "overallScore": 50, "suggestions": "Try to add more details and elaboration to your sentences, expand your vocabulary to include more expressive words, and work on maintaining a more natural flow in longer speech segments."}	50
6	1	conversation	\N	2025-04-11 02:21:29.818444	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744334483282}]	{"grammar": {"score": 30, "strengths": ["Use of basic sentence structure"], "improvements": ["Add punctuation for clarity", "Work on subject-verb agreement", "Avoid run-on sentences"]}, "fluency": {"score": 20, "strengths": ["Consistent speech flow"], "improvements": ["Reduce the use of filler words", "Address hesitations", "Minimize word repetitions"]}, "vocabulary": {"score": 20, "strengths": ["Basic word choice"], "improvements": ["Expand vocabulary range", "Incorporate more idiomatic expressions", "Enhance naturalness"]}, "overallScore": 23, "suggestions": "Focus on using proper punctuation for clarity, work on reducing filler words and hesitations, and try to incorporate more varied vocabulary and idiomatic expressions for a more natural flow."}	23
7	1	conversation	\N	2025-04-11 02:22:02.677735	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744334492817}, {"role": "user", "content": "hi I am inverto is there any specific topic would you like to talk about", "timestamp": 1744334500315}, {"role": "assistant", "content": "Hi! We can talk about anything you'd like - hobbies, interests, current events, or even random fun facts. Just let me know what you're in the mood to discuss!", "timestamp": 1744334501002}, {"role": "user", "content": "just let me know what you're in the mood to discuss", "timestamp": 1744334513716}, {"role": "assistant", "content": "I'm always up for a chat about travel, food, movies, or technology. Or if you have any questions or need advice, feel free to ask! What interests you?", "timestamp": 1744334514397}, {"role": "user", "content": "I'm always offer a chat about travel food", "timestamp": 1744334519865}]	{"grammar": {"score": 70, "strengths": ["Correct verb tenses used", "Subject-verb agreement is generally accurate", "Clarity in sentence structure"], "improvements": ["Add punctuation for clearer sentence boundaries", "Avoid run-on sentences", "Vary sentence structures for better fluency"]}, "fluency": {"score": 60, "strengths": ["Overall coherent flow of speech", "Natural rhythm in speaking", "No excessive use of filler words"], "improvements": ["Reduce hesitations", "Work on smoother transitions between ideas", "Minimize repetitions"]}, "vocabulary": {"score": 70, "strengths": ["Appropriate word choice for the context", "Usage of common idiomatic expressions", "Clear and understandable vocabulary"], "improvements": ["Incorporate more diverse vocabulary", "Expand on specialized travel and food-related terms", "Use more descriptive adjectives and adverbs"]}, "overallScore": 66, "suggestions": "Focus on adding punctuation to enhance clarity, reduce hesitations to improve fluency, and expand your vocabulary with more varied terms for richer expression."}	66
8	1	conversation	\N	2025-04-11 02:23:15.142742	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744334561744}, {"role": "user", "content": "hello my name is chintan gatia today I would like to talk about my friends", "timestamp": 1744334573326}, {"role": "assistant", "content": "Hello Chintan! Sure, I'd love to hear about your friends. What do you like most about them?", "timestamp": 1744334574065}, {"role": "user", "content": "what do you like most about them well I like how they are behaving with other people", "timestamp": 1744334588052}, {"role": "assistant", "content": "That's wonderful! It's great to have friends who treat others with kindness and respect. It sounds like you have a great group of friends.", "timestamp": 1744334588602}]	{"grammar": {"score": 75, "strengths": ["Correct subject-verb agreement", "Clear sentence structure", "Use of punctuation"], "improvements": ["More varied sentence structures", "Avoid run-on sentences", "Use conjunctions to connect ideas"]}, "fluency": {"score": 70, "strengths": ["Steady speaking flow", "Clear pronunciation", "Minimal use of filler words"], "improvements": ["Reduce hesitations", "Avoid repetitions", "Work on smoother transitions between ideas"]}, "vocabulary": {"score": 75, "strengths": ["Clear and relevant vocabulary choice", "Use of descriptive words", "Effective communication of ideas"], "improvements": ["Incorporate more idiomatic expressions", "Expand use of synonyms", "Enhance word variety"]}, "overallScore": 73, "suggestions": "Focus on enhancing sentence structures, reducing hesitations, and incorporating more idiomatic expressions to further improve your spoken English proficiency."}	73
9	1	conversation	\N	2025-04-11 02:25:51.945653	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744334646181}, {"role": "user", "content": "specific topic would you like to talk about hi Tony I would like to talk about my friends", "timestamp": 1744334657556}, {"role": "assistant", "content": "Of course! Friends are always a great topic. What would you like to share or talk about regarding your friends?", "timestamp": 1744334658279}, {"role": "user", "content": "always a great topic what would you like to share or talk about regarding your friends well I would like to talk about how they are behaving with other in good way", "timestamp": 1744334674260}, {"role": "assistant", "content": "That's great to hear that your friends are behaving well with others! It's important to have friends who are kind and respectful. How do you think their behavior positively impacts your social circle?", "timestamp": 1744334674821}, {"role": "user", "content": "I don't really know", "timestamp": 1744334694254}, {"role": "assistant", "content": "It's always nice to have friends who set a good example with their behavior. Maybe their positive actions create a friendly and supportive atmosphere for everyone in your social circle. It's great that you value good behavior in your friends!", "timestamp": 1744334695195}, {"role": "user", "content": "behavior maybe their positive actions create a friendly and supported atmosphere for everyone in your social circle it's great that you value good behaviour in your friends", "timestamp": 1744334711163}, {"role": "assistant", "content": "Absolutely, creating a friendly and supportive atmosphere is key to maintaining strong and positive friendships. It's wonderful that you appreciate good behavior in your friends. It shows that you value respect and kindness in your relationships.", "timestamp": 1744334712050}, {"role": "user", "content": "absolutely creating a friendly and supportive atmosphere is key to maintaining strong and positive functions it's wonderful that you appreciate your friends it shows that you value respect and kindness in your relationships", "timestamp": 1744334728694}, {"role": "assistant", "content": "Yes, respect and kindness are fundamental in any healthy relationship. It's great that you prioritize these values in your friendships. Building a supportive and positive atmosphere with friends can help create lasting and fulfilling connections.", "timestamp": 1744334729459}, {"role": "user", "content": "yes respect and kindness of fundamental in any healthy relationship it's great that you prioritize these values in your friendships building a supportive and positive atmosphere with friends can help create lasting and fulfilling connections", "timestamp": 1744334745664}, {"role": "assistant", "content": "Absolutely, fostering respect and kindness in our friendships is essential for building meaningful and lasting connections. It's clear that you understand the importance of creating a supportive and positive atmosphere with your friends. Keep nurturing those values in your relationships!", "timestamp": 1744334746428}]	{"grammar": {"score": 75, "strengths": ["Correct use of verb tenses", "Appropriate sentence structure", "Effective use of clauses"], "improvements": ["Punctuation errors", "Incomplete sentences", "Lack of variety in sentence structures"]}, "fluency": {"score": 70, "strengths": ["Maintained conversation flow", "Limited use of filler words", "Hesitation was minimal"], "improvements": ["Repetitive phrases", "Unnatural pauses", "Lack of varied sentence lengths"]}, "vocabulary": {"score": 80, "strengths": ["Appropriate use of idiomatic expressions", "Good range of vocabulary", "Natural word choice"], "improvements": ["Limited use of advanced vocabulary", "Repetitive use of certain terms", "Opportunity to include more nuanced vocabulary"]}, "overallScore": 75, "suggestions": "Work on incorporating varied sentence structures, improve punctuation for clearer communication, and consider expanding vocabulary with more advanced terms to enhance expressiveness and depth."}	75
10	1	conversation	\N	2025-04-11 02:28:33.773447	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744334883108}, {"role": "user", "content": "is there any specific topic would you like to talk about hi today I would like to talk about my friends", "timestamp": 1744334894268}, {"role": "assistant", "content": "Sure, I'd be happy to talk about your friends. What would you like to share or discuss about them?", "timestamp": 1744334894938}, {"role": "user", "content": "what would you like to share or discuss about them", "timestamp": 1744334903047}, {"role": "assistant", "content": "I'd be interested to hear about what makes your friends special to you, or maybe a funny or memorable moment you've shared with them.", "timestamp": 1744334903604}]	{"grammar": {"score": 60, "strengths": ["Correct subject-verb agreement", "Clear sentence structure", "Correct use of prepositions"], "improvements": ["Add punctuation for clearer structure", "Reduce run-on sentences", "Use more varied sentence structures"]}, "fluency": {"score": 50, "strengths": ["Clear enunciation", "Steady speaking pace", "Attempt to initiate a conversation"], "improvements": ["Reduce hesitations and fillers", "Work on smoother transitions between thoughts", "Avoid repeated phrases"]}, "vocabulary": {"score": 60, "strengths": ["Basic vocabulary appropriate for the topic", "Clear communication of ideas", "Use of common conversational phrases"], "improvements": ["Incorporate more descriptive adjectives", "Expand vocabulary for richer expression", "Include idiomatic expressions for more natural speech"]}, "overallScore": 56, "suggestions": "Focus on using punctuation for clearer sentence structure, practice reducing hesitations and fillers for smoother speech flow, and work on enriching your vocabulary with descriptive adjectives and idiomatic expressions."}	56
11	1	conversation	\N	2025-04-11 02:37:11.864877	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744335400228}, {"role": "user", "content": "is there any specific topic would you like to talk about hello today I would like to talk about my friend", "timestamp": 1744335411320}, {"role": "assistant", "content": "Sure, I'd be happy to talk about your friend. What's on your mind?", "timestamp": 1744335412100}, {"role": "user", "content": "so I'll be happy to talk about your friend what's on your mind", "timestamp": 1744335419029}, {"role": "assistant", "content": "I'm here to listen! What would you like to share about your friend?", "timestamp": 1744335419501}, {"role": "user", "content": "I'm here to listen what would you like to share about your friend", "timestamp": 1744335425658}, {"role": "assistant", "content": "Oh, sorry for the mix-up. I'd like to hear more about your friend. What's something interesting about them?", "timestamp": 1744335426243}]	{"grammar": {"score": 55, "strengths": ["Correct subject-verb agreement", "Use of conjunctions", "Clear questions"], "improvements": ["Punctuation needed for clarity", "Incomplete sentences", "Lacks varied sentence structures"]}, "fluency": {"score": 60, "strengths": ["Attempt at continuous speech", "Minimal use of filler words", "Overall understandable"], "improvements": ["Work on smoother transitions between ideas", "Reduce hesitations", "Avoid repetition"]}, "vocabulary": {"score": 60, "strengths": ["Basic vocabulary used appropriately", "Clear communication of ideas", "Attempts to express thoughts"], "improvements": ["Expand range of vocabulary", "Incorporate more idiomatic expressions", "Enhance word choice for depth"]}, "overallScore": 58, "suggestions": "Focus on adding more varied sentence structures, expanding vocabulary range, and practicing smoother transitions for improved fluency."}	58
12	1	conversation	\N	2025-04-11 02:40:12.248807	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744335568900}, {"role": "user", "content": "hello today I would like to talk about my friends", "timestamp": 1744335579045}, {"role": "assistant", "content": "Of course! What would you like to share about your friends?", "timestamp": 1744335579634}, {"role": "user", "content": "what would you like to share about your friends my friends are always good", "timestamp": 1744335589695}, {"role": "assistant", "content": "That's wonderful to hear! Good friends are such a valuable part of our lives. What do you appreciate most about your friends?", "timestamp": 1744335590226}, {"role": "user", "content": "good friends are such a valuable part of our lives what do you appreciate most about your", "timestamp": 1744335601185}, {"role": "assistant", "content": "I feel grateful for my friends' support, understanding, and laughter. They bring so much joy and positivity to my life. How do your friends support you?", "timestamp": 1744335601887}]	{"grammar": {"score": 60, "strengths": ["Correct use of subject-verb agreement", "Clear sentence structure in some parts", "Use of punctuation"], "improvements": ["Work on verb tenses for consistency", "Incomplete sentences need to be revised", "Add conjunctions for smoother flow"]}, "fluency": {"score": 50, "strengths": ["Some natural pauses for emphasis", "Attempt to continue speaking despite hesitations", "Decent rhythm in speech"], "improvements": ["Reduce filler words like 'uh' and 'um'", "Address repetitions for clearer communication", "Work on reducing hesitations"]}, "vocabulary": {"score": 70, "strengths": ["Use of common vocabulary related to the topic", "Attempts to express thoughts with limited vocabulary", "Basic idiomatic expressions used"], "improvements": ["Expand vocabulary to include more descriptive words", "Incorporate more varied expressions and phrases", "Enhance use of synonyms"]}, "overallScore": 60, "suggestions": "Focus on practicing verb tenses, reducing filler words, and expanding your vocabulary to improve overall spoken English proficiency."}	60
13	1	conversation	\N	2025-04-11 02:43:52.133159	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744335749680}, {"role": "user", "content": "can you hear me", "timestamp": 1744335758936}, {"role": "assistant", "content": "Yes, I can hear you. How can I help you today?", "timestamp": 1744335759562}, {"role": "user", "content": "like to go to the supermarket but I don't know what to buy", "timestamp": 1744335781604}, {"role": "assistant", "content": "No problem! What type of food or meals do you usually enjoy? That could help us come up with a shopping list.", "timestamp": 1744335782283}, {"role": "user", "content": "what type of food were meals do you usually enjoy that could help us come up with the shopping list", "timestamp": 1744335793395}, {"role": "assistant", "content": "Some ideas for a basic shopping list could include items like fruits and vegetables, whole grains (like rice and pasta), protein sources (such as chicken, tofu, or beans), dairy or dairy alternatives, and any specific items you like for snacks or treats. Let me know if you'd like more specific suggestions!", "timestamp": 1744335794276}, {"role": "user", "content": "well", "timestamp": 1744335795785}, {"role": "assistant", "content": "If you have any specific preferences or dietary requirements, feel free to share them so I can offer more tailored suggestions for your shopping list. Otherwise, I can provide some general ideas for a versatile shopping list.", "timestamp": 1744335796450}, {"role": "user", "content": "how many specific preferences for dietary requirements well I am vegetarian", "timestamp": 1744335805653}, {"role": "assistant", "content": "Great! As a vegetarian, you can include items like fruits, vegetables, legumes (such as lentils and chickpeas), tofu or tempeh, nuts and seeds, dairy or dairy alternatives, whole grains, and vegetarian sources of protein like quinoa or edamame in your shopping list. Is there anything specific you're looking to cook or any favorite veggie meals you enjoy?", "timestamp": 1744335806621}, {"role": "user", "content": "vegetables LEGOs such as lentils and chickpeas tofu or Tempe nuts and seeds dairy or dairy alternatives", "timestamp": 1744335824325}, {"role": "assistant", "content": "It sounds like you have a good list going! Make sure to include a variety of colorful vegetables, different types of legumes for protein, tofu or tempeh for texture, nuts and seeds for healthy fats, and dairy alternatives like almond milk or soy yogurt. Have fun exploring different vegetarian recipes with these ingredients!", "timestamp": 1744335825196}]	{"grammar": {"score": 65, "strengths": ["Correct subject-verb agreement", "Some use of clauses", "Adequate punctuation"], "improvements": ["Work on sentence structure", "Address run-on sentences", "Use more diverse punctuation"]}, "fluency": {"score": 60, "strengths": ["Shows some speaking flow", "Uses filler words naturally", "Moves between ideas"], "improvements": ["Reduce hesitations", "Minimize repetitions", "Improve rhythm and pace"]}, "vocabulary": {"score": 70, "strengths": ["Uses a variety of food-related vocabulary", "Includes dietary terms", "Some idiomatic expressions used"], "improvements": ["Expand range of vocabulary beyond food", "Incorporate more varied idiomatic expressions", "Use transitions for smoother speech"]}, "overallScore": 65, "suggestions": "Focus on organizing thoughts into clearer sentences, practice speaking more fluently with reduced hesitations, and enrich vocabulary with diverse idiomatic expressions."}	65
14	1	conversation	\N	2025-04-11 02:49:47.356444	[{"role": "assistant", "content": "Hi, I am Engverto. Is there any specific topic you'd like to talk about?", "timestamp": 1744336181268}]	{"grammar": {"score": 20, "strengths": ["Transcript too short to evaluate."], "improvements": ["Not enough sentence structure detected.", "Use complete thoughts when speaking.", "Try to form proper subject-verb combinations."]}, "fluency": {"score": 25, "strengths": ["Transcript was processed successfully."], "improvements": ["Fluency could not be assessed from short input.", "More extended speaking is needed.", "Avoid long pauses and fillers."]}, "vocabulary": {"score": 22, "strengths": ["Transcript used very basic vocabulary."], "improvements": ["Not enough variety to analyze.", "Try using more descriptive words.", "Include real-world examples."]}, "overallScore": 22, "summary": "The response was too short or unclear to evaluate properly. Try speaking in full sentences for at least 20\\u201330 seconds."}	22
15	1	conversation	\N	2025-04-11 02:50:05.355402	[{"role": "assistant", "content": "Hi, I am Engverto. Is there any specific topic you'd like to talk about?", "timestamp": 1744336192520}]	{"grammar": {"score": 20, "strengths": ["Transcript too short to evaluate."], "improvements": ["Not enough sentence structure detected.", "Use complete thoughts when speaking.", "Try to form proper subject-verb combinations."]}, "fluency": {"score": 25, "strengths": ["Transcript was processed successfully."], "improvements": ["Fluency could not be assessed from short input.", "More extended speaking is needed.", "Avoid long pauses and fillers."]}, "vocabulary": {"score": 22, "strengths": ["Transcript used very basic vocabulary."], "improvements": ["Not enough variety to analyze.", "Try using more descriptive words.", "Include real-world examples."]}, "overallScore": 22, "summary": "The response was too short or unclear to evaluate properly. Try speaking in full sentences for at least 20\\u201330 seconds."}	22
16	1	conversation	\N	2025-04-11 02:50:54.229027	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744336225947}, {"role": "user", "content": "hello today I would like to talk about my friends", "timestamp": 1744336236134}, {"role": "assistant", "content": "Of course! What would you like to share about your friends?", "timestamp": 1744336236854}, {"role": "user", "content": "well my friends are really good", "timestamp": 1744336246722}, {"role": "assistant", "content": "That's great to hear! What do you enjoy most about spending time with your friends?", "timestamp": 1744336247313}]	{"grammar": {"score": 60, "strengths": ["Correct verb tense usage", "Subject-verb agreement", "Clear sentence structure"], "improvements": ["Add punctuation (comma)", "Expand on ideas for more complex sentences", "Avoid run-on sentences"]}, "fluency": {"score": 50, "strengths": ["Steady speaking flow", "Clear pronunciation", "Maintained topic coherence"], "improvements": ["Reduce filler words ('well')", "Reduce hesitations", "Enhance sentence transitions"]}, "vocabulary": {"score": 50, "strengths": ["Use of common vocabulary", "Clear word choice", "Basic idiomatic expressions"], "improvements": ["Expand vocabulary for variety", "Incorporate more precise adjectives/adverbs", "Use more sophisticated language"]}, "overallScore": 53, "suggestions": "Work on using a wider range of vocabulary, reduce filler words and hesitations for better fluency, and practice structuring more complex sentences with proper punctuation."}	53
17	1	conversation	\N	2025-04-11 02:53:07.209363	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744336336475}, {"role": "user", "content": "hello can you hear me", "timestamp": 1744336345927}, {"role": "assistant", "content": "Yes, I can hear you! How can I help you today?", "timestamp": 1744336346543}, {"role": "user", "content": "today I would like to talk about my friends", "timestamp": 1744336358765}, {"role": "assistant", "content": "Of course! What would you like to share or discuss about your friends?", "timestamp": 1744336359238}, {"role": "user", "content": "well my friends are very good personalities", "timestamp": 1744336372023}, {"role": "assistant", "content": "That's wonderful to hear! It's so important to have friends who are positive influences and good people. What do you enjoy most about spending time with them?", "timestamp": 1744336372625}, {"role": "user", "content": "it's so important to have friends who are positive influences and good people", "timestamp": 1744336381491}, {"role": "assistant", "content": "Absolutely, surrounding ourselves with positive and supportive friends can have a great impact on our well-being. It sounds like you have really good friends. How do they positively influence your life?", "timestamp": 1744336382104}, {"role": "user", "content": "what do you enjoy most about spend", "timestamp": 1744336383731}, {"role": "assistant", "content": "What do you enjoy most about spending time with your friends?", "timestamp": 1744336384197}]	{"grammar": {"score": 60, "strengths": ["Proper use of verb tenses", "Subject-verb agreement mostly correct", "Clear sentence structure"], "improvements": ["Incomplete sentence ('What do you enjoy most about spend')", "Missing punctuation at the end of the transcript", "Fragmented thoughts"]}, "fluency": {"score": 50, "strengths": ["Clear pronunciation", "Some natural pauses", "Decent rhythm"], "improvements": ["Hesitations and pauses", "Repetitions", "Use of filler words ('well', 'um')"]}, "vocabulary": {"score": 60, "strengths": ["Appropriate word choice for the topic", "Use of idiomatic expressions ('positive influences')", "Clear communication of ideas"], "improvements": ["Limited vocabulary variety", "Lack of depth in expression", "More descriptive vocabulary needed"]}, "overallScore": 56, "suggestions": "Focus on expanding vocabulary to enhance expression, work on reducing hesitations and fillers for smoother speech flow."}	56
18	1	conversation	\N	2025-04-11 02:56:55.827905	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744336580996}, {"role": "user", "content": "hi today I would like to talk about my friends", "timestamp": 1744336589577}, {"role": "assistant", "content": "Sure! What would you like to share about your friends?", "timestamp": 1744336590070}, {"role": "user", "content": "well there are really good", "timestamp": 1744336599996}, {"role": "assistant", "content": "That's great to hear! What do you enjoy most about spending time with your friends?", "timestamp": 1744336600447}, {"role": "user", "content": "spending time with your friends", "timestamp": 1744336609049}, {"role": "assistant", "content": "Absolutely! Spending time with friends can be so enjoyable and fulfilling. Do you have a favorite activity you like to do together?", "timestamp": 1744336609581}]	{"grammar": {"score": 60, "strengths": ["Correct verb conjugation", "Use of simple sentence structures", "Use of appropriate prepositions"], "improvements": ["Lack of punctuation", "Incomplete sentences", "Need for subject-verb agreement"]}, "fluency": {"score": 50, "strengths": ["Slow and deliberate speech", "Clear pronunciation", "Use of appropriate filler words"], "improvements": ["Hesitations and pauses", "Repetitions", "Lack of varied sentence structures"]}, "vocabulary": {"score": 50, "strengths": ["Use of everyday vocabulary", "Clear expression of ideas", "Use of common phrases"], "improvements": ["Limited vocabulary range", "Absence of descriptive words", "Need for idiomatic expressions"]}, "overallScore": 53.3, "suggestions": "To improve, focus on using a wider vocabulary range, practicing varied sentence structures, and working on fluency by reducing hesitations."}	53
19	1	conversation	\N	2025-04-11 02:58:57.544165	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744336646877}, {"role": "user", "content": "hello today I would like to talk about my friends", "timestamp": 1744336656496}, {"role": "assistant", "content": "Sure, let's talk about your friends.", "timestamp": 1744336657209}, {"role": "user", "content": "my friends are really good personalities and I love to gain knowledge from them", "timestamp": 1744336669679}, {"role": "assistant", "content": "That's wonderful! Friends are great!", "timestamp": 1744336670151}, {"role": "user", "content": "well", "timestamp": 1744336679568}, {"role": "assistant", "content": "Got it. Share more anytime.", "timestamp": 1744336679992}, {"role": "user", "content": "what should I share you", "timestamp": 1744336689898}, {"role": "assistant", "content": "Anything you'd like to talk about.", "timestamp": 1744336690574}, {"role": "user", "content": "I would like to talk about my friends is I told you", "timestamp": 1744336700287}, {"role": "assistant", "content": "Sure, tell me about your friends.", "timestamp": 1744336700995}, {"role": "user", "content": "tell me about your friends", "timestamp": 1744336706678}, {"role": "assistant", "content": "I can't share specific information.", "timestamp": 1744336707079}, {"role": "user", "content": "well they are", "timestamp": 1744336708681}, {"role": "assistant", "content": "Great! Friends are important.", "timestamp": 1744336709240}, {"role": "user", "content": "I believe that as well", "timestamp": 1744336719809}, {"role": "assistant", "content": "Friendship is valuable and special.", "timestamp": 1744336720333}]	{"grammar": {"score": 70, "strengths": ["Correct subject-verb agreement", "Correct use of verb tenses", "Some use of clauses"], "improvements": ["Punctuation errors", "Incomplete sentences", "More varied sentence structure"]}, "fluency": {"score": 60, "strengths": ["Some natural pauses", "Some rhythm in speech", "Clear topic introduction"], "improvements": ["Filler words impact fluency", "Repetitive sentence structure", "Hesitations affect flow"]}, "vocabulary": {"score": 70, "strengths": ["Use of varied vocabulary", "Correct word choice", "Attempt to use idiomatic expressions"], "improvements": ["Expand on idiomatic expressions", "Use more sophisticated vocabulary", "Avoid repetitive phrasing"]}, "overallScore": 66, "suggestions": "Work on using more varied sentence structures, reducing filler words, and expanding vocabulary to enhance overall spoken English proficiency."}	66
20	1	conversation	\N	2025-04-11 03:06:28.707113	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744337185163}]	{"grammar": {"score": 20, "strengths": ["Use of basic sentence structure."], "improvements": ["Work on verb tense consistency.", "Add punctuation for clearer meaning.", "Avoid run-on sentences."]}, "fluency": {"score": 10, "strengths": ["Some natural pauses."], "improvements": ["Reduce the use of filler words.", "Work on speaking flow.", "Minimize repetitions."]}, "vocabulary": {"score": 15, "strengths": ["Basic vocabulary used."], "improvements": ["Expand the range of word choice.", "Incorporate more idiomatic expressions.", "Increase naturalness of language."]}, "overallScore": 15, "suggestions": "Focus on verb tense consistency, reduce filler words, and work on expanding vocabulary for better fluency and coherence."}	15
21	1	conversation	\N	2025-04-11 03:12:59.784344	[{"role": "assistant", "content": "Hi, I am Engverto,is there any specific topic would you like to talk about?", "timestamp": 1744337543667}, {"role": "user", "content": "hi today I would like to talk about my friends", "timestamp": 1744337552899}, {"role": "assistant", "content": "Sure, let's talk about them.", "timestamp": 1744337553563}, {"role": "user", "content": "well they are really good friends and I love to spare time with them", "timestamp": 1744337565845}, {"role": "assistant", "content": "That's wonderful to hear.", "timestamp": 1744337566287}, {"role": "user", "content": "as you can see I have", "timestamp": 1744337573694}, {"role": "assistant", "content": "Sorry, I didn't get that. Can you please clarify?", "timestamp": 1744337574146}, {"role": "user", "content": "implemented everything", "timestamp": 1744337575765}, {"role": "assistant", "content": "That's great news. Good job!", "timestamp": 1744337576272}]	{"grammar": {"score": 60, "strengths": ["Correct subject-verb agreement", "Clear sentence structure", "Punctuation usage"], "improvements": ["Incomplete sentences", "Lack of conjunctions for smoother flow", "Run-on sentence"]}, "fluency": {"score": 50, "strengths": ["Steady speaking pace", "Limited use of filler words", "Clear pronunciation"], "improvements": ["Hesitations and pauses", "Repetitions", "Lacks natural flow"]}, "vocabulary": {"score": 70, "strengths": ["Basic vocabulary use is appropriate", "Clear communication of ideas", "Simple idiomatic expressions"], "improvements": ["Limited word variety", "Lack of complex vocabulary", "More idiomatic expressions can enhance fluency"]}, "overallScore": 60, "suggestions": "Work on using conjunctions to connect ideas more smoothly, reduce hesitations to improve fluency, and expand vocabulary with more diverse and complex words for better expression."}	60
\.


--
-- TOC entry 4965 (class 0 OID 24606)
-- Dependencies: 218
-- Data for Name: user_activity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_activity (id, user_id, module, test_id, score, feedback, submitted_at) FROM stdin;
1	1	reading	\N	7	Great job!	2025-04-10 07:44:34.163489
2	1	writing	\N	6	Needs improvement.	2025-04-10 07:44:34.163489
3	1	listening	\N	8	Well done.	2025-04-10 07:44:34.163489
4	1	speaking	\N	5	Practice pronunciation.	2025-04-10 07:44:34.163489
\.


--
-- TOC entry 4963 (class 0 OID 24597)
-- Dependencies: 216
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, username) FROM stdin;
1	Chintan
\.


--
-- TOC entry 4978 (class 0 OID 24733)
-- Dependencies: 231
-- Data for Name: writing_feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.writing_feedback (id, user_id, writing_type, situation, task, prompt_text, user_writing, score_total, score_content_relevance, score_content_depth, score_organization_paragraphs, score_organization_coherence, score_grammar_tenses, score_grammar_agreement_punctuation, score_vocab_range, score_vocab_idioms, score_style_audience, comment_grammar, comment_vocabulary, comment_structure, comment_tone, rewrite_suggestion, improved_version, created_at) FROM stdin;
1	1	letter				defed	7	2	1	1	1	1	1	1	1	1	The text is incomplete and lacks proper grammar.	The vocabulary used is very limited.	The writing lacks any coherent structure.	The tone is unclear due to the brevity of the text.	Please provide a complete and coherent text for assessment.	A full, well-structured letter is needed for a thorough evaluation.	2025-04-10 06:05:26.916815
2	1	letter				Hi, today I would like to request about extension 	46	6	4	6	5	4	5	5	3	4	There are some tense inconsistencies and punctuation errors.	Try to use a wider range of vocabulary and avoid informal language like 'Hi'.	The text lacks proper paragraph structure and coherence.	The tone is too casual for a formal letter.	Consider starting the letter with a formal greeting and clearly stating your request. Also, work on improving the overall structure and grammar.	A full improved version would involve rewriting the letter with a formal tone, correct grammar, and better organization.	2025-04-10 16:31:05.984399
3	1	letter				jhkjbjb	0	0	0	0	0	0	0	0	0	0	The text provided is too short to assess grammar.	The vocabulary used is insufficient for evaluation.	There is no discernible structure in the text.	There is no identifiable tone or style in the text.	Improved rewrite suggestion: Please provide a longer and more coherent text for assessment.	Full improved version: Unfortunately, without sufficient content, it is not possible to provide a full improved version.	2025-04-10 23:42:10.730859
4	1	letter				today I would Like to Write an email to request my school assignment 	49	6	5	6	5	10	9	7	5	6	Overall good, but watch out for subject-verb agreement.	Could use more varied and sophisticated words.	Ensure a clear introduction, body, and conclusion.	Formal tone needed for a school request letter.	Consider starting with a formal greeting and clearly stating your purpose. Provide details about the assignment and politely request for it.	Your letter could be improved by enhancing vocabulary, organizing content better, and using a more formal tone throughout.	2025-04-11 00:36:37.069351
5	1	letter				Hi,\nI hope you will be fine, I would like write letter to request to for extension of project deadlie.	46	6	5	6	5	10	8	6	5	6	Work on using the correct verb tenses and improve punctuation.	Expand your vocabulary to enhance the clarity and effectiveness of your writing.	Focus on structuring your letter with proper introduction, body, and conclusion.	Maintain a professional and polite tone throughout your letter.	Consider revising the opening for a more formal tone, like 'Dear [Recipient's Name],' and provide more details about the project extension request.	Here is a full improved version of your letter:\nDear [Recipient's Name],\nI hope this message finds you well. I am writing to formally request an extension for the project deadline. [Provide reasons for the extension and any relevant details.] I appreciate your consideration and understanding in this matter. Thank you for your attention to this request.\n\nSincerely,\n[Your Name]	2025-04-11 02:16:27.889661
6	1	letter				rrrrr	7	2	1	1	1	1	1	1	1	1	The text lacks proper grammar usage.	Limited vocabulary use.	The letter lacks proper structure and coherence.	The tone is unclear and inappropriate for a letter.	Improved rewrite suggestion: Please consider elaborating on the content and ensuring proper grammar, vocabulary, and tone to make the letter more effective.	A full improved version is necessary to meet basic writing standards.	2025-04-11 03:16:42.357241
\.


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 228
-- Name: reading_answers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reading_answers_id_seq', 46, true);


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 224
-- Name: reading_passages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reading_passages_id_seq', 8, true);


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 226
-- Name: reading_questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reading_questions_id_seq', 29, true);


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 219
-- Name: speaking_sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.speaking_sessions_id_seq', 21, true);


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 217
-- Name: user_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_activity_id_seq', 4, true);


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 215
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, false);


--
-- TOC entry 4997 (class 0 OID 0)
-- Dependencies: 230
-- Name: writing_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.writing_feedback_id_seq', 6, true);


--
-- TOC entry 4801 (class 2606 OID 24677)
-- Name: listening_history listening_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_history
    ADD CONSTRAINT listening_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4799 (class 2606 OID 24664)
-- Name: listening_questions listening_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_questions
    ADD CONSTRAINT listening_questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4797 (class 2606 OID 24657)
-- Name: listening_tests listening_tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_tests
    ADD CONSTRAINT listening_tests_pkey PRIMARY KEY (id);


--
-- TOC entry 4807 (class 2606 OID 24720)
-- Name: reading_answers reading_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_answers
    ADD CONSTRAINT reading_answers_pkey PRIMARY KEY (id);


--
-- TOC entry 4803 (class 2606 OID 24696)
-- Name: reading_passages reading_passages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_passages
    ADD CONSTRAINT reading_passages_pkey PRIMARY KEY (id);


--
-- TOC entry 4805 (class 2606 OID 24705)
-- Name: reading_questions reading_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_questions
    ADD CONSTRAINT reading_questions_pkey PRIMARY KEY (id);


--
-- TOC entry 4795 (class 2606 OID 24629)
-- Name: speaking_sessions speaking_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speaking_sessions
    ADD CONSTRAINT speaking_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4793 (class 2606 OID 24614)
-- Name: user_activity user_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_activity
    ADD CONSTRAINT user_activity_pkey PRIMARY KEY (id);


--
-- TOC entry 4791 (class 2606 OID 24604)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4809 (class 2606 OID 24741)
-- Name: writing_feedback writing_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writing_feedback
    ADD CONSTRAINT writing_feedback_pkey PRIMARY KEY (id);


--
-- TOC entry 4818 (class 2606 OID 24747)
-- Name: writing_feedback fk_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.writing_feedback
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4813 (class 2606 OID 24683)
-- Name: listening_history listening_history_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_history
    ADD CONSTRAINT listening_history_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.listening_tests(id);


--
-- TOC entry 4814 (class 2606 OID 24678)
-- Name: listening_history listening_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_history
    ADD CONSTRAINT listening_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4812 (class 2606 OID 24665)
-- Name: listening_questions listening_questions_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.listening_questions
    ADD CONSTRAINT listening_questions_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.listening_tests(id) ON DELETE CASCADE;


--
-- TOC entry 4816 (class 2606 OID 24721)
-- Name: reading_answers reading_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_answers
    ADD CONSTRAINT reading_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.reading_questions(id) ON DELETE CASCADE;


--
-- TOC entry 4817 (class 2606 OID 24726)
-- Name: reading_answers reading_answers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_answers
    ADD CONSTRAINT reading_answers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4815 (class 2606 OID 24706)
-- Name: reading_questions reading_questions_passage_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reading_questions
    ADD CONSTRAINT reading_questions_passage_id_fkey FOREIGN KEY (passage_id) REFERENCES public.reading_passages(id) ON DELETE CASCADE;


--
-- TOC entry 4811 (class 2606 OID 24630)
-- Name: speaking_sessions speaking_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.speaking_sessions
    ADD CONSTRAINT speaking_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4810 (class 2606 OID 24615)
-- Name: user_activity user_activity_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_activity
    ADD CONSTRAINT user_activity_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


-- Completed on 2025-04-11 03:52:07

--
-- PostgreSQL database dump complete
--

