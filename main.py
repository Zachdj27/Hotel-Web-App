from database import engine
import models
from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
import models
from database import get_db
from datetime import date

# create database tables if they do not exist
models.Base.metadata.create_all(bind=engine)

app = FastAPI()

@app.get("/rooms/available")
def get_available_rooms(
    start_date: date, 
    end_date: date, 
    capacity: int = None, 
    price_min: float = 0, 
    price_max: float = 1000, 
    db: Session = Depends(get_db)
):
    query = db.query(models.Chambre).filter(models.Chambre.is_available == True)
    
    if capacity:
        query = query.filter(models.Chambre.capacity >= capacity)
    
    query = query.filter(models.Chambre.price.between(price_min, price_max))

    return query.all()
