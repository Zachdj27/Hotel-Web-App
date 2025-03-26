from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.routes import rooms, bookings, clients
from app.database import Base, engine

app = FastAPI()

# for frontend communication
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:3000","http://localhost:5173"], 
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(rooms.router)
app.include_router(bookings.router)
app.include_router(clients.router)

#create tables if they don’t exist
Base.metadata.create_all(bind=engine)

    
# @app.get("/test_available_rooms/")
# def test_available_rooms(
#     start_date: str = "2025-05-01",
#     end_date: str = "2025-05-05",
#     capacity: int = 1,
#     superficie: int = 20,
#     price: float = 350,
#     hotel_id: int = 1,
#     db: Session = Depends(get_db)
# ):
#     rooms = get_available_rooms(db=db, start_date=start_date, end_date=end_date, capacity=capacity,superficie=superficie,price=price, hotel_id=hotel_id)
#     return rooms 

# @app.get("/test_create_bookings/")
# def test_available_rooms(
#     client_id: int = 1,
#     room_id: int = 1,
#     entry_date: str = "2025-05-01",
#     leaving_date: str = "2025-05-05",
#     status: str = "Réservé",
#     db: Session = Depends(get_db)
# ):
#     test_booking = schemas.BookingCreate(
#         client_id=client_id,
#         room_id=room_id,
#         entry_date=entry_date,
#         leaving_date=leaving_date,
#         status=status
#     )
#     bookings = create_booking(test_booking, db)
#     return bookings

# @app.get("/test_update_booking_status/")
# def test_update_booking_status(
#     booking_id: int = 1,
#     status: str = "Confirmé",
#     db: Session = Depends(get_db)
# ):
#     updated_booking = update_booking_status_api(db=db, booking_id=booking_id, status=status)
    
#     if not updated_booking:
#         return {"error": "Booking not found"}

#     return updated_booking
    
# @app.get("/test_create_client/")
# def test_create_client(
#     nom_complet: str = "Jean-Guy Gagnon",
#     adresse: str = "27 Rue du Test",
#     NAS: str = "300355345",
#     db: Session = Depends(get_db)
# ):
#     test_client = schemas.ClientCreate(
#         nom_complet=nom_complet,
#         NAS=NAS,
#         adresse=adresse
#     )
#     clients = create_client(test_client, db)
#     return clients
    

