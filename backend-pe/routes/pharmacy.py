from fastapi import APIRouter, HTTPException
from models.mpharmacy import Pharmacy
from config.database import collection_name
from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from bson import ObjectId

pharmacy = APIRouter()


# Return all pharmacies in the mdb
@pharmacy.get("/")
async def get_all_pharmacies():
    pharmacies = await collection_name.find().to_list(1000)
    return pharmaciesEntity(pharmacies)



# create a pharmacy in mdb
@pharmacy.post("/")
async def add_pharmacy(pharmacy: Pharmacy):
    pharmacy_dict = pharmacy.dict()
    pharmacy_id = await collection_name.insert_one(pharmacy_dict)
    return {"id": str(pharmacy_id.inserted_id)}




# get pharmacy by id
@pharmacy.get("/{pharmacy_id}")
async def get_pharmacy(pharmacy_id: str):
    pharmacy = await collection_name.find_one({"_id": ObjectId(pharmacy_id)})
    if pharmacy:
        return pharmacyEntity(pharmacy)
    else:
        raise HTTPException(status_code=404, detail="Pharmacy not found")



@pharmacy.get("/name/{pharmacy_name}")
async def get_pharmacy_by_name(pharmacy_name: str):
    pharmacy = await collection_name.find_one({"name":pharmacy_name})
    if pharmacy:
        return pharmacyEntity(pharmacy)
    
    else:
        raise HTTPException(status_code= 404 , detail ="Pharmacy not found")



@pharmacy.delete("/{pharmacy_id}")
async def delete_pharmacy(pharmacy_id: str):
    result = await collection_name.delete_one({"_id": ObjectId(pharmacy_id)})
    if result.deleted_count == 0:
        raise HTTPException(status_code=404, detail="Pharmacy not found")
    return {"status": "success", "message": "Pharmacy deleted successfully"}

@pharmacy.put("/{pharmacy_id}")
async def update_pharmacy(pharmacy_id: str, updated_pharmacy: Pharmacy):
    pharmacy_dict = updated_pharmacy.dict()
    result = await collection_name.replace_one({"_id": ObjectId(pharmacy_id)}, pharmacy_dict)
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Pharmacy not found")
    return {"status": "success", "message": "Pharmacy updated successfully"}