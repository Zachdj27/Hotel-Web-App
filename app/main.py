from fastapi import FastAPI, Depends, HTTPException
from sqlalchemy.orm import Session
from app import models, crud, schemas, database
from typing import Optional


app = FastAPI()

# Dependency to get the DB session
def get_db():
    db = database.SessionLocal()
    try:
        yield db
    finally:
        db.close()
        
@app.get("/rooms/available/")
def get_available_rooms(
    start_date: str, 
    end_date: str, 
    capacity: int, 
    price: float, 
    hotel_id: Optional[int] = None, 
    db: Session = Depends(get_db)
):
    rooms = crud.get_available_rooms(db, start_date, end_date, capacity, price, hotel_id)
    return {"available_rooms": rooms}

@app.post("/bookings/")
def create_booking(booking: schemas.BookingCreate, db: Session = Depends(get_db)):
    try:
        return crud.create_booking(db, booking)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    
@app.get("/test_available_rooms/")
def test_available_rooms(
    start_date: str = "2025-05-01",
    end_date: str = "2025-05-05",
    capacity: int = 1,
    price: float = 350,
    hotel_id: int = 1,
    db: Session = Depends(get_db)
):
    rooms = get_available_rooms(db=db, start_date=start_date, end_date=end_date, capacity=capacity, price=price, hotel_id=hotel_id)
    return rooms 

@app.get("/test_create_bookings/")
def test_available_rooms(
    client_id: int = 1,
    room_id: int = 1,
    entry_date: str = "2025-05-01",
    leaving_date: str = "2025-05-05",
    status: str = "Réservé",
    db: Session = Depends(get_db)
):
    test_booking = schemas.BookingCreate(
        client_id=client_id,
        room_id=room_id,
        entry_date=entry_date,
        leaving_date=leaving_date,
        status=status
    )
    bookings = create_booking(test_booking, db)
    return bookings

