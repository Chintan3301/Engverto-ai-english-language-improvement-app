Hi, My name is Chintan Gadhiya, This is a bit complex project, if you find problems to run the code after following the steps I have given below then you can contact me on (l38859742@stdent.ua92.ac.uk    or chintangadhiya2509@gmail.com ) I will help to run the web application on your system  

  

  

Please follow everything step by step 

  

  

Install Python https://www.python.org/downloads/ 

Install Node.js and npm 
 https://nodejs.org/ 

Install PostgreSQL 

When you install the PostgreSQL then make sure you keep the password    “Asdfg@123”      and port = 5433       ----- if you don’t do this, then the database will not connect. Make sure, please.  

  

And If you have done but not exact then you have to postgresql://your_username:your_password@localhost:5432/engverto ------------ edit this each files so it can be connected to the database. 

Download the latest version  

  

Add the  the PostgreSQL Database 

Find engverto_dash.sql file in database folder 

Open pgAdmin or any SQL GUI. 

Create a new database (e.g., engverto). 

Right-click on it → Go to Restore. 

Choose the .sql backup file you gave. 

Under Restore Options: 

 Check Include CREATE 

Check Include DROP 

Click Restore. 

 

Set Up Flask Backend 

Open terminal  

cd flask-backends/dashboard-api 

python -m venv venv 

Activate the virtual environment: 

Windows: terminal in vs code 

venv\Scripts\activate 

Mac/Linux: 

source venv/bin/activate 

Install required packages: 

terminal in vs code 

pip install Flask Flask-Cors Flask-SQLAlchemy psycopg2-binary openai python-dotenv 

  

then Run Flask Backend 

python app.py 

You should see: 

Running on http://127.0.0.1:5000 

  

Set Up React Frontend 

Do this for each module folder I shared (like reading-frontend, dashboard, etc.). You can do by following steps below  

 \\\\\\\\\\        -------  PLEASE RUN COMMAND IN FOLLWING ONE BY ONE ---//////// 

 Terminal 1  

cd react-apps/dashboard 

npm install 

npm install -D tailwindcss@3 postcss autoprefixer 

npx tailwindcss init -p 

npm start 

  

  

If you are using PowerShell in the terminal, you will get Execution Policy if you want to solve it do this  

Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned  

If you don’t want to do this then use Command prompt  in terminal 

And do  :   

cd react-apps/dashboard 

npm install 

npm start 

Now you have to follow the steps and terminal 1 mins open a terminal in vs , terminal 2 means open another teminal similarly follow for other terminals  Run the app: 

  

  

Terminal 2 

cd react-apps/Listening/client 

npm install 

npm install -D tailwindcss@3 postcss autoprefixer 

npx tailwindcss init -p 

npm start 

Terminal 3 

cd react-apps/Reading/client 

npm install 

npm install -D tailwindcss@3 postcss autoprefixer 

npx tailwindcss init -p 

npm start 

  

Terminal 4 

cd react-apps/Speaking/speaking-app 

npm install 

npm install -D tailwindcss@3 postcss autoprefixer 

npx tailwindcss init -p 

npm start 

  

Terminal 5 

cd react-apps/Writing/ai-writing-app/frontend 

npm install 

npm install -D tailwindcss@3 postcss autoprefixer 

npx tailwindcss init -p 

npm start 

  

You will see a different port for each (like 3001 for reading, 3002 for writing, etc.), no need to change anything else. 

  

  

--------------- all set for dashboard now and done set for reading, writing, listening, and speaking   frontend ------------ 

Set Up the Flask Backend for speaking 

Open Terminal 

cd react-apps/Speaking/server 

python -m venv venv 

venv\Scripts\activate    # Windows only 

Install dependencies: 

pip install flask 

pip install flask-cors 

pip install psycopg2-binary 

pip install python-dotenv 

pip install openai 
 
if you get error about openai is not working, then try  pip install openai==0.28 
 
  

  

Now run the command un same terminal  

python app.py 

you will see * Running on http://127.0.0.1:5004 

  

  

---------------------------- Speaking backend sis done  

BACKEND SETUP Flask for Reading  

cd react-apps/Reading/server 

python -m venv venv 

venv\Scripts\activate     # for Windows 

# source venv/bin/activate  ← for Mac/Linux 

  

pip install flask flask_sqlalchemy flask_cors psycopg2 openai python-dotenv 

if openai is not working then try  this code :  pip install openai==0.28 

---------seed.py is to inject (insert) test sets in database so only use if you don’t find any.----- 

Now run the  Backend 

python run.py 

 This will run on: http://localhost:5001 

 HOW IT WORKS 

 Reading Tests 

A random test is served by: 
 GET http://localhost:5001/api/tests 

Answers are submitted to: 
 POST http://localhost:5001/api/submit 
 Body includes answers and user_id 

------------------------------------------ reading backend section is done now ----------------- 

  

BACKEND SETUP for listening 

Step 1: Open Terminal  

cd react-apps/Listening/server 

Step 2: Create virtual environment: 

python -m venv venv 

venv\Scripts\activate 

Step 3: Install dependencies manually (no requirements.txt) 

pip install Flask 

pip install Flask-Cors 

pip install Flask-SQLAlchemy 

pip install psycopg2-binary 

Step 5: Run Flask server 

Now run command  

 python run.py 

It should run on http://localhost:5003 

  

5. AUDIO FILES 

Make sure the audio files are present in: 

server/static/audio/ 

--- You can see  

server/static/audio/a-friend.mp3 

server/static/audio/family.mp3 

  

6. OPTIONAL: Seed Data 

If you provided a seed.py script, the client can run: 

Ony if require python seed.py 

To populate listening_tests and listening_questions. 

---------------------------------------- listening backend is done now -------------- 

  

  

  

  

BACKEND SETUP for writing 

Step 1: Open terminal and navigate to backend/ folder 

cd react-apps/Writing/ai-writing-app/backend 

app.py 

Step 2: Create & activate virtual environment 

python -m venv venv 

venv\Scripts\activate 

Mac/Linux: 

python3 -m venv venv 

source venv/bin/activate 

Step 3: Manually install required Python packages 

pip install Flask 

pip install Flask-Cors 

pip install openai 

pip install Flask-SQLAlchemy 

pip install psycopg2-binary 

 

Run backend on port 5002 

python app.py 

You should see: 

Running on http://127.0.0.1:5002 

 

 