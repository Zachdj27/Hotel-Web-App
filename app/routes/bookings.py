from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import crud, schemas, database

router = APIRouter(prefix="/bookings", tags=["Bookings"])

@router.post("/")
def create_booking(booking: schemas.BookingCreate, db: Session = Depends(database.get_db)):
    try:
        return crud.create_booking(db, booking)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.put("/{booking_id}/status")
def update_booking_status_api(booking_id: int, status: str, db: Session = Depends(database.get_db)):
    updated_booking = crud.update_booking_status(db, booking_id, status)
    if not updated_booking:
        raise HTTPException(status_code=404, detail="Booking not found")
    return updated_booking
