from sqlalchemy import Column, Integer, String, ForeignKey, Date, DECIMAL
from sqlalchemy.orm import relationship
from database import Base

#tables
class ChaineHoteliere(Base):
    __tablename__ = "chaine_hoteliere"
    chain_id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)

class Hotel(Base):
    __tablename__ = "hotel"
    hotel_id = Column(Integer, primary_key=True, index=True)
    chain_id = Column(Integer, ForeignKey("chaine_hoteliere.chain_id"))
    name = Column(String, nullable=False)

class Chambre(Base):
    __tablename__ = "chambre"
    room_id = Column(Integer, primary_key=True, index=True)
    hotel_id = Column(Integer, ForeignKey("hotel.hotel_id"))
    prix = Column(DECIMAL, nullable=False)
