from sqlalchemy import Column, Integer, String, Text, ForeignKey, DECIMAL, Date, Boolean, CheckConstraint
from sqlalchemy.orm import relationship, declarative_base

#Models SQL en sous forme Python
Base = declarative_base()

class ChaineHoteliere(Base):
    __tablename__ = "chaine_hoteliere"

    chain_id = Column(Integer, primary_key=True, autoincrement=True)
    name = Column(String(255), nullable=False)
    adresse_bureau = Column(Text)
    nombre_hotels = Column(Integer)
    email = Column(String(100))

    hotels = relationship("Hotel", back_populates="chaine")


class Hotel(Base):
    __tablename__ = "hotel"

    hotel_id = Column(Integer, primary_key=True, autoincrement=True)
    chain_id = Column(Integer, ForeignKey("chaine_hoteliere.chain_id", ondelete="CASCADE"))
    name = Column(String(255), nullable=False)
    adresse = Column(Text)
    numero_telephone = Column(String(20))
    email = Column(String(100))
    classement = Column(Integer, CheckConstraint("classement BETWEEN 1 AND 5"))
    pays = Column(String(255))
    zone = Column(String(255))

    chaine = relationship("ChaineHoteliere", back_populates="hotels")
    chambres = relationship("Chambre", back_populates="hotel")
    employees = relationship("Employee", back_populates="hotel")


class Chambre(Base):
    __tablename__ = "chambre"

    room_id = Column(Integer, primary_key=True, autoincrement=True)
    hotel_id = Column(Integer, ForeignKey("hotel.hotel_id", ondelete="CASCADE"))
    numero_chambre = Column(String(10), nullable=False)
    prix = Column(DECIMAL(10, 2), nullable=False)
    commodites = Column(Text)
    capacite = Column(Integer, CheckConstraint("capacite > 0"))
    vue = Column(String(50))
    etendre = Column(Boolean, default=False)
    dommages = Column(Text)
    superficie = Column(Integer, CheckConstraint("superficie > 0"))

    hotel = relationship("Hotel", back_populates="chambres")
    bookings = relationship("Booking", back_populates="chambre")


class Employee(Base):
    __tablename__ = "employee"

    employee_id = Column(Integer, primary_key=True, autoincrement=True)
    hotel_id = Column(Integer, ForeignKey("hotel.hotel_id", ondelete="CASCADE"))
    NAS = Column(String(20), unique=True, nullable=False)
    nom_complet = Column(String(255), nullable=False)
    adresse = Column(Text)
    poste = Column(String(100))

    hotel = relationship("Hotel", back_populates="employees")


class Client(Base):
    __tablename__ = "client"

    client_id = Column(Integer, primary_key=True, autoincrement=True)
    NAS = Column(String(20), unique=True, nullable=False)
    nom_complet = Column(String(255), nullable=False)
    adresse = Column(Text)
    date_enregistrement = Column(Date)

    bookings = relationship("Booking", back_populates="client")
    locations = relationship("Location", back_populates="client")


class Booking(Base):
    __tablename__ = "booking"

    booking_id = Column(Integer, primary_key=True, autoincrement=True)
    client_id = Column(Integer, ForeignKey("client.client_id", ondelete="CASCADE"))
    room_id = Column(Integer, ForeignKey("chambre.room_id", ondelete="CASCADE"))
    entry_date = Column(Date, nullable=False)
    leaving_date = Column(Date, nullable=False)
    status = Column(String(20), CheckConstraint("status IN ('Réservé', 'Confirmé', 'Annulé')"))

    client = relationship("Client", back_populates="bookings")
    chambre = relationship("Chambre", back_populates="bookings")
    location = relationship("Location", uselist=False, back_populates="booking")


class Location(Base):
    __tablename__ = "location"

    location_id = Column(Integer, primary_key=True, autoincrement=True)
    booking_id = Column(Integer, ForeignKey("booking.booking_id", ondelete="CASCADE"), unique=True, nullable=True)
    client_id = Column(Integer, ForeignKey("client.client_id", ondelete="CASCADE"))
    l_date = Column(Date)

    booking = relationship("Booking", back_populates="location")
    client = relationship("Client", back_populates="locations")
