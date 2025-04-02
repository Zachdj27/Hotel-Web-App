from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import crud, schemas, database

router = APIRouter(prefix="/clients", tags=["Clients"])

@router.post("/create-account")
def create_client(client: schemas.ClientCreate, db: Session = Depends(database.get_db)):
    try:
        return crud.create_client(db, client)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.post("/login")
def client_login(login_details: schemas.ClientLogin, db: Session = Depends(database.get_db)):
    try:
        return crud.client_login(db, login_details)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.delete("/{client_id}")
def delete_client_endpoint(client_id: int, db: Session = Depends(database.get_db)):
    result = crud.delete_client(db, client_id)
    if not result["success"]:
        raise HTTPException(status_code=404, detail=result["message"])
    return result
