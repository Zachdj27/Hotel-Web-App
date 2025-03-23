from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# set up connection with database
DATABASE_URL = "postgresql://postgres:$QLM0n$t@@localhost:5432/ProjetCSI2532"

engine = create_engine(DATABASE_URL)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
