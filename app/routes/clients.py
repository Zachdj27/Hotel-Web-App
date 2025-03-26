from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import crud, schemas, database

router = APIRouter(prefix="/clients", tags=["Clients"])

@router.post("/")
def create_client(client: schemas.ClientCreate, db: Session = Depends(database.get_db)):
    try:
        return crud.create_client(db, client)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
