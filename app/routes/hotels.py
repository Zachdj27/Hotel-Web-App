from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from app.database import get_db
from app.crud import get_hotel_capacities, get_rooms_by_zone
from app.schemas import HotelCapacity, RoomsByZone
from typing import List

router = APIRouter()

@router.get("/hotels/capacity/", response_model=List[HotelCapacity])
def fetch_hotel_capacity(db: Session = Depends(get_db)):
    return get_hotel_capacities(db)

@router.get("/zones/available-rooms/", response_model=List[RoomsByZone])
def fetch_rooms_by_zone(db: Session = Depends(get_db)):
    return get_rooms_by_zone(db)
