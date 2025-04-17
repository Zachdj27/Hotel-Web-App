# CRUD Hotel Web Application
This Web Application allows users to create/delete an account, search rooms by filters, book rooms,modify reservations, and more! 

## Tech Stack 
Python, JavaScript, PostgreSQL, React, FastAPI, HTML, CSS

https://github.com/user-attachments/assets/ee1097ba-2279-4a7f-bffa-9b136f731fff

# Setup Guide

## Step 1: Create and restore the database
In your Terminal or Command Prompt, go to the project directory.

First, create the database using the following command:

```bash
createdb -U postgres ProjetCSI2532
```
Then, restore the database from the initDB.sql file:
```bash
psql -U postgres -d ProjetCSI2532 -f initDB.sql
```

Note: If you already have a database named ProjetCSI2532 in pgadmin then
this will not work. If this is the case, change the db name (ProjetCSI2532)
to somehting else for both commands

If these commands still do not work then please make sure you have PostgreSQL installed on your computer and replace postgres (default username) by your own username if using a different one. 

## Alternative Step 1 (If there is an error):
We will create the database using psql.

Open the Terminal and run:
```bash
psql -U postgres 
```
Once inside the psql prompt (you'll see something like postgres=#), type: 
```bash
CREATE DATABASE ProjetCSI2532;
\q 
```

Then run this: 
```bash
psql -U postgres -d ProjetCSI2532 -f initDB.sql
```

## Second Alternative Step 1 (If there is an error):
You can manually install the database.
Open pgadmin and create a new databse named "ProjetCSI2532".

In this order, copy and paste into the query tool eveything in: 
1. baseDeDonnee.sql
2. sampleData.sql
3. sampleRoomData.sql

## Step 2: Set Up Backend
In the main directory creat a file named ".env" if there is none. Otherwise, modify the existing one to have your own SQL credentials (your_username and your_password). 

In this file named ".env" there should be one line:
```bash
DATABASE_URL=postgresql://your_username:your_password@your_host:5432/your_db_name
```

Note: if your password or username has any special characters this might cause an error, especially if your passrowd ends with a "@". If this is the case, for the sake of the demo, please change your password or username for it to contain no speical characters. 

Create a virutal environment using:
```bash
python -m venv venv
```
Or:
```bash
python3 -m venv venv
```

Activate the virutal env.

If on MacOS:
```bash
source venv/bin/activate 
```

If on Windows:
```bash
venv\Scripts\activate
```


Navigate to the app Directory using
```bash
cd app
```

Run:
```bash
pip install -r requirements.txt
```
If this does not work, try:
```bash
pip3 install -r requirements.txt
```
Navigate back to the main Directory using:
```bash
cd ..
```
Run this int the terminal to start the backend:
```bash
uvicorn app.main:app --reload
```
## Step 3: Set Up Front End

Open another terminal/Command Prompt window and go the the e-hotels-frontend directory using:
```bash
e-hotels-frontend
```

Install dependencies:
```bash
npm install
```

To run the frontend:
```bash
npm run dev
```
You should see that it is running at http://localhost:5173/ or a similar adress. Copy the adress of the frontend and copy it into your web browser.
Everything should work correctly now!
