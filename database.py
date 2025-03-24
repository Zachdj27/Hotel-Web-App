from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base
from dotenv import load_dotenv

# set up connection with database
#Il faut d'abord créer un fichier .env et écrire:
#DATABASE_URL=postgresql://your_username:your_password@your_host:your_port/your_db_name
load_dotenv()
engine = create_engine("DATABASE_URL")
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
