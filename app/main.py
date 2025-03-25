from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from app import models, schemas, database


app = FastAPI()

# Dependency to get the DB session
def get_db():
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()

# @app.post("/hotels/")
# def create_hotel(hotel: schemas.HotelBase, db: Session = Depends(get_db)):
#     return crud.create_hotel(db, hotel)

# @app.get("/hotels/{hotel_id}")
# def read_hotel(hotel_id: int, db: Session = Depends(get_db)):
#     return crud.get_hotel(db, hotel_id)
