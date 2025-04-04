from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from app import crud, schemas, database

router = APIRouter(prefix="/employees", tags=["Employees"])

# @router.post("/create-account")
# def create_client(client: schemas.ClientCreate, db: Session = Depends(database.get_db)):
#     try:
#         return crud.create_client(db, client)
#     except Exception as e:
#         raise HTTPException(status_code=400, detail=str(e))

@router.post("/login")
def employee_login(login_details: schemas.EmployeeLogin, db: Session = Depends(database.get_db)):
    try:
        return crud.employee_login(db, login_details)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    
@router.delete("/{employee_id}")
def delete_employee_endpoint(employee_id: int, db: Session = Depends(database.get_db)):
    result = crud.delete_employee(db, employee_id)
    if not result["success"]:
        raise HTTPException(status_code=404, detail=result["message"])
    return result

@router.post("/create-account")
def create_employee(employee: schemas.EmployeeCreate, db: Session = Depends(database.get_db)):
    try:
        return crud.create_employee(db, employee)
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))
    
@router.put("/update/{employee_id}")
def update_employee_endpoint(employee_id: int, employee_data: schemas.EmployeeUpdate, db: Session = Depends(database.get_db)):
    result = crud.update_employee(db, employee_id, employee_data)
    if not result["success"]:
        raise HTTPException(status_code=404, detail=result["message"])
    return result

@router.get("/get-employee/{employee_id}")
def get_employee_by_id(employee_id: int, db: Session = Depends(database.get_db)):
    return crud.get_employee(db, employee_id)
    
# @router.delete("/{client_id}")
# def delete_client_endpoint(client_id: int, db: Session = Depends(database.get_db)):
#     result = crud.delete_client(db, client_id)
#     if not result["success"]:
#         raise HTTPException(status_code=404, detail=result["message"])
#     return result
