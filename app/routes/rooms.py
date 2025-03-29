from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app import crud, database

router = APIRouter(prefix="/rooms", tags=["Rooms"])

@router.get("/available/")
def get_available_rooms(
    start_date: str, 
    end_date: str, 
    capacity: int = None, 
    superficie: int = None,
    price: float = None, 
    hotel_id: int = None, 
    pays: str = None,
    zone: str = None,
    db: Session = Depends(database.get_db)
):
    return {"available_rooms": crud.get_available_rooms(db, start_date, end_date, capacity, superficie, price, hotel_id, pays, zone)}
