from sqlalchemy import Column, Integer, String, ForeignKey, Date, DECIMAL
from sqlalchemy.orm import relationship
from database import Base

#tables
from sqlalchemy import Column, Integer, String, ForeignKey, Date, DECIMAL, Boolean
from sqlalchemy.orm import relationship
from database import Base

class ChaineHoteliere(Base):
    __tablename__ = "chaine_hoteliere"
    chain_id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)

    hotels = relationship("Hotel", back_populates="chain")

class Hotel(Base):
    __tablename__ = "hotel"
    hotel_id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    chain_id = Column(Integer, ForeignKey("chaine_hoteliere.chain_id"))
    category = Column(String, nullable=False)
    zone = Column(String, nullable=False)

    chain = relationship("ChaineHoteliere", back_populates="hotels")
    rooms = relationship("Chambre", back_populates="hotel")

class Chambre(Base):
    __tablename__ = "chambre"
    room_id = Column(Integer, primary_key=True, index=True)
    hotel_id = Column(Integer, ForeignKey("hotel.hotel_id"))
    capacity = Column(Integer, nullable=False)
    size = Column(Integer, nullable=False)  # size in square meters
    price = Column(DECIMAL, nullable=False)
    is_available = Column(Boolean, default=True)

    hotel = relationship("Hotel", back_populates="rooms")
    reservations = relationship("Reservation", back_populates="room")

class Client(Base):
    __tablename__ = "client"
    client_id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    phone = Column(String, nullable=False)

    reservations = relationship("Reservation", back_populates="client")

class Employee(Base):
    __tablename__ = "employee"
    employee_id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    email = Column(String, unique=True, nullable=False)
    hotel_id = Column(Integer, ForeignKey("hotel.hotel_id"))
    position = Column(String, nullable=False)

    hotel = relationship("Hotel")

class Reservation(Base):
    __tablename__ = "reservation"
    reservation_id = Column(Integer, primary_key=True, index=True)
    client_id = Column(Integer, ForeignKey("client.client_id"))
    room_id = Column(Integer, ForeignKey("chambre.room_id"))
    start_date = Column(Date, nullable=False)
    end_date = Column(Date, nullable=False)
    is_confirmed = Column(Boolean, default=False)

    client = relationship("Client", back_populates="reservations")
    room = relationship("Chambre", back_populates="reservations")

class Payment(Base):
    __tablename__ = "payment"
    payment_id = Column(Integer, primary_key=True, index=True)
    reservation_id = Column(Integer, ForeignKey("reservation.reservation_id"))
    amount = Column(DECIMAL, nullable=False)
    payment_date = Column(Date, nullable=False)

    reservation = relationship("Reservation")
