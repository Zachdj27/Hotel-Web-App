from sqlalchemy.orm import Session
from . import models, schemas
from datetime import datetime
from typing import Optional

def create_client(db: Session, client: schemas.ClientCreate):
    db_client = models.Client(**client.dict())
    db.add(db_client)
    db.commit()
    db.refresh(db_client)
    return db_client

def get_client(db: Session, client_id: int):
    return db.query(models.Client).filter(models.Client.client_id == client_id).first()

def get_available_rooms(
    db: Session,
    start_date: str,
    end_date: str,
    capacity: int,
    superficie: int,
    price: Optional[float] = None,
    hotel_id: Optional[int] = None
) -> list:
    #convert string dates to datetime objects
    start_date = datetime.strptime(start_date, "%Y-%m-%d")
    end_date = datetime.strptime(end_date, "%Y-%m-%d")

    # query to filter by room capacity, price, and hotel
    query = db.query(models.Chambre).filter(
        models.Chambre.capacite >= capacity,  
    )
    query = db.query(models.Chambre).filter(
        models.Chambre.superficie >= superficie,  
    )

    if price is not None:
        query = query.filter(models.Chambre.prix <= price)

    if hotel_id:
        query = query.filter(models.Chambre.hotel_id == hotel_id)

    #get all rooms that meet the basic criteria
    rooms = query.all()

    #filter rooms by availability
    available_rooms = []
    for room in rooms:
        if check_room_availability(db, room.room_id, start_date, end_date):
            available_rooms.append(room)

    return available_rooms

def create_booking(db: Session, booking: schemas.BookingCreate):
    db_booking = models.Booking(**booking.dict())
    db.add(db_booking)
    db.commit()
    db.refresh(db_booking)
    return db_booking

def update_booking_status(db: Session, booking_id: int, status: str):
    db_booking = db.query(models.Booking).filter(models.Booking.booking_id == booking_id).first()
    if not db_booking:
        return None
    db_booking.status = status
    db.commit()
    db.refresh(db_booking)
    return db_booking

def check_room_availability(db: Session, room_id: int, entry_date: str, leaving_date: str):
    return db.query(models.Booking).filter(
        models.Booking.room_id == room_id,
        models.Booking.status.in_(['Réservé', 'Confirmé']),
        models.Booking.entry_date <= leaving_date,
        models.Booking.leaving_date >= entry_date
    ).count() == 0

