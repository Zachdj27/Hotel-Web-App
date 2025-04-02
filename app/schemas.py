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
    prix: Optional[float]
    commodites: Optional[str]
    capacite: Optional[int]
    superficie: Optional[int]
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
    NAS: str
    nom_complet: str
    adresse: str
    password: str
    date_enregistrement: Optional[date] = None

class ClientCreate(ClientBase):
    pass

class Client(ClientBase):
    client_id: int

    class Config:
        orm_mode = True
class ClientResponse(ClientBase):
    client_id: int  #include the client_id

    class Config:
        from_attributes = True

class RoomBase(BaseModel):
    numero_chambre: str
    prix: float
    capacite: int
    hotel_id: int

class BookingBase(BaseModel):
    client_id: int
    room_id: int
    entry_date: date
    leaving_date: date
    status: str

class BookingCreate(BookingBase):
    pass

class HotelCapacity(BaseModel):
    hotel_id: int
    name: str
    capacite_total_disponible: int

class RoomsByZone(BaseModel):
    zone: str
    nombre_chambres_disponibles: int
    
class ClientLogin(BaseModel):
    NAS: str
    password: str
