from pydantic import BaseModel
from datetime import date
from typing import List, Optional

#Schemas for API Requests
class ChaineHoteliereBase(BaseModel):
    name: str
    adresse_bureau: Optional[str]
    nombre_hotels: Optional[int]
    email: Optional[str]


class HotelBase(BaseModel):
    chain_id: int
    name: str
    adresse: Optional[str]
    numero_telephone: Optional[str]
    email: Optional[str]
    classement: Optional[int]
    pays: Optional[str]
    zone: Optional[str]


class ChambreBase(BaseModel):
    hotel_id: int
    numero_chambre: str
    prix: float
    commodites: Optional[str]
    capacite: int
    vue: Optional[str]
    etendre: Optional[bool] = False
    dommages: Optional[str]


class BookingBase(BaseModel):
    client_id: int
    room_id: int
    entry_date: date
    leaving_date: date
    status: str

class ClientBase(BaseModel):
    nom_complet: str
    adresse: str

class ClientCreate(ClientBase):
    pass

class Client(ClientBase):
    client_id: int

    class Config:
        orm_mode = True

class RoomBase(BaseModel):
    numero_chambre: str
    prix: float
    capacite: int
    hotel_id: int

class BookingBase(BaseModel):
    client_id: int
    room_id: int
    entry_date: str
    leaving_date: str
    status: str

class BookingCreate(BookingBase):
    pass
