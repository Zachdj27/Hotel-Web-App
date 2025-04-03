from sqlalchemy.orm import Session
from . import models, schemas
from datetime import datetime
from typing import Optional
from datetime import date
from sqlalchemy import text

def create_client(db: Session, client: schemas.ClientCreate):
    db_client = models.Client(
        NAS=client.NAS,
        nom_complet=client.nom_complet,
        adresse=client.adresse,
        password=client.password,
        date_enregistrement=date.today()  #today
    )
    db.add(db_client)
    db.commit()
    db.refresh(db_client)
    return {"successCreation": True, "client": db_client}

def client_login(db: Session, login_details: schemas.ClientLogin):
    client = db.query(models.Client).filter(
        models.Client.NAS == login_details.NAS,
        models.Client.password == login_details.password
    ).first()

    if not client:
        return {"success": False, "client_id": None}

    return {"success": True, "client_id": client.client_id}


def get_client(db: Session, client_id: int):
    return db.query(models.Client).filter(models.Client.client_id == client_id).first()

def get_available_rooms(
    db: Session,
    start_date: str,
    end_date: str,
    capacity: Optional[int] = None,
    superficie: Optional[int] = None,
    price: Optional[float] = None,
    chain_id: Optional[int] = None,
    pays: Optional[str] = None,
    zone: Optional[str]=None,
    classement: Optional[int] = None
) -> list:
    #convert string dates to datetime objects
    start_date = datetime.strptime(start_date, "%Y-%m-%d")
    end_date = datetime.strptime(end_date, "%Y-%m-%d")

    # query to filter by room capacity, price, and hotel
    query = db.query(models.Chambre, models.Hotel).join(models.Hotel)
    if capacity:
        query = query.filter(models.Chambre.capacite >= capacity)
    if superficie:
        query = query.filter(models.Chambre.superficie >= superficie)
    if price:
        query = query.filter(models.Chambre.prix <= price)
    if chain_id:
        query = query.filter(models.Chambre.chain_id == chain_id)
    if pays:  
        query = query.filter(models.Hotel.pays == pays)
    if zone:  
        query = query.filter(models.Hotel.zone == zone)
    if classement:
        query = query.filter(models.Hotel.classement == classement)

    #get all rooms that meet the basic criteria
    rooms = query.all()

    #filter rooms by availability
    available_rooms = []
    for room_tuple in rooms:
            chambre = room_tuple[0]
            hotel = room_tuple[1]
            
            if check_room_availability(db, chambre.room_id, start_date, end_date):
                # Construct a dictionary with all the properties you need
                room_data = {
                    "room_id": chambre.room_id,
                    "prix": chambre.prix,
                    "capacite": chambre.capacite,
                    "superficie": chambre.superficie,
                    "hotel_name": hotel.name,
                    "pays": hotel.pays,
                    "zone": hotel.zone,
                    "classement": hotel.classement,
                    "chain_id": hotel.chain_id 
                }
                available_rooms.append(room_data)

    return available_rooms

def create_booking(db: Session, booking: schemas.BookingCreate):
    db_booking = models.Booking(**booking.dict())
    db.add(db_booking)
    db.commit()
    db.refresh(db_booking)
    return {"successBooking": True, "booking": db_booking}

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

def get_hotel_capacities(db: Session):
    query = text("SELECT * FROM Capacite_hotel_disponible")
    result = db.execute(query).fetchall()
    return [row._asdict() for row in result]

def get_rooms_by_zone(db: Session):
    query = text("SELECT * FROM Chambre_par_zone")
    result = db.execute(query).fetchall()
    return [row._asdict() for row in result]

def delete_client(db: Session, client_id: int):
    #find the client by ID and 
    client = db.query(models.Client).filter(models.Client.client_id == client_id).first()
    
    #if client exists, delete it
    if client:
        db.delete(client)
        db.commit()
        return {"success": True, "message": f"Client with ID {client_id} deleted successfully"}
    
    #if client doesn't exist, return an error message
    return {"success": False, "message": f"Client with ID {client_id} not found"}


def employee_login(db: Session, login_details: schemas.EmployeeLogin):
    employee = db.query(models.Employee).filter(
        models.Employee.nas == login_details.nas,
        models.Employee.password == login_details.password
    ).first()

    if not employee:
        return {"success": False, "employee_id": None}

    return {"success": True, "employee_id": employee.employee_id}

def get_clients(db: Session):
    return db.query(models.Client).all()

def get_bookings(db: Session):
    bookings = (
        db.query(models.Booking, models.Client)
        .join(models.Client, models.Booking.client_id == models.Client.client_id) 
        .all()
    )

    # Convert objects to dictionaries
    formatted_bookings = [
        {
            "booking_id": booking.Booking.booking_id,
            "room_id": booking.Booking.room_id,
            "entry_date": booking.Booking.entry_date.strftime("%Y-%m-%d"),
            "leaving_date": booking.Booking.leaving_date.strftime("%Y-%m-%d"),
            "status": booking.Booking.status,
            "client": {
                "client_id": booking.Client.client_id,
                "name": booking.Client.nom_complet,
                "NAS": booking.Client.NAS,
            }
        }
        for booking in bookings
    ]

    return formatted_bookings
