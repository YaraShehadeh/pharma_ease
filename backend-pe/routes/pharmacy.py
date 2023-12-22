from fastapi import APIRouter, HTTPException
from models.mpharmacy import Pharmacy
from models.mpharmacist import Pharmacist
from models.mdrugs import Drug
from config.database import collection_name
from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from bson import ObjectId
from models.mlocation import Location
from typing import List, Optional
from services.pharmacy_operations import *

from dao.pharmacy_dao import PharmacyDAO

pharmacy = APIRouter()


# Return all pharmacies in the mdb
@pharmacy.get("/all")
async def get_all_pharmacies():
    return await PharmacyDAO.get_all_pharmacies2()

# # Fetch all pharmacies that have the specified drug
# @pharmacy.get("/search_drug")
# async def search_drug(drug_name: str, user_lat: float, user_lon: float):
#     return await search_for_drug_service(drug_name, user_lat, user_lon)

# Endpoint to search for multiple drugs
@pharmacy.post("/searchHoldingPharmacies")
async def search_drugs(drug_names: List[str], user_lat: float, user_lon: float):
    return await search_for_drugs_service(drug_names, user_lat, user_lon)


# add a drug to the pharmacy
@pharmacy.post("/{pharmacy_name}/add_drug")
async def add_drug_to_pharmacy(pharmacy_name: str, drug: Drug):
    return await add_drug_service(pharmacy_name, drug)


# create a pharmacy in mdb
@pharmacy.post("/create")
async def add_pharmacy(pharmacy: Pharmacy):
    # return await add_pharmacy_service(pharmacy)
    try:
        result = await PharmacyDAO.create_pharmacy(pharmacy=pharmacy)
        return result 
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

 
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
        raise HTTPException(status_code=404, detail="Pharmacy not found")



@pharmacy.delete("/{pharmacy_id}")
async def delete_pharmacy(pharmacy_id: str):
    try:
        result = await PharmacyDAO.delete_pharmacy(pharmacy_id=pharmacy_id)
        if result.deleted_count == 0:
            raise HTTPException(status_code=404, detail= "Pharmacy not found")
        
        return {"status": "success", "message": f"Pharmacy with id {pharmacy_id} deleted successfully"}
    
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))

@pharmacy.put("/{pharmacy_id}")
async def update_pharmacy(pharmacy_id: str, updated_pharmacy: Pharmacy):
    pharmacy_dict = updated_pharmacy.dict()
    result = await collection_name.replace_one(
        {"_id": ObjectId(pharmacy_id)}, pharmacy_dict)
    if result.matched_count == 0:
        raise HTTPException(status_code=404, detail="Pharmacy not found")
    return {"status": "success", "message": "Pharmacy updated successfully"}






# add a pharmacist to a pharmacy
@pharmacy.post("/add_pharmacist/{pharmacy_name}")
async def add_pharmacist_to_pharmacy_by_name(pharmacy_name: str, pharmacist: Pharmacist):
    # Fetch the pharmacy document by its name
    pharmacy = await collection_name.find_one({"name": pharmacy_name})
    if not pharmacy:
        raise HTTPException(status_code=404, detail="Pharmacy not found")

    # Append the new pharmacist
    if "pharmacists" not in pharmacy:
        pharmacy["pharmacists"] = [pharmacist.dict()]
    else:
        pharmacy["pharmacists"].append(pharmacist.dict())

    # Update the pharmacy document
    await collection_name.update_one(
        {"name": pharmacy_name},
        {"$set": {"pharmacists": pharmacy["pharmacists"]}}
    )

    return {"message": "Pharmacist added successfully"}




@pharmacy.delete("/remove_pharmacist/{pharmacy_name}/{pharmacist_username}")
async def remove_pharmacist_by_name(pharmacy_name: str, pharmacist_username: str):
    # Fetch the pharmacy document by name
    pharmacy = await collection_name.find_one({"name": pharmacy_name})
    if not pharmacy:
        raise HTTPException(status_code=404, detail="Pharmacy not found")

    # Check if the pharmacist exists in the pharmacy
    pharmacists = pharmacy.get("pharmacists", [])
    pharmacist_exists = any(pharmacist for pharmacist in pharmacists if pharmacist.get('username') == pharmacist_username)

    if not pharmacist_exists:
        raise HTTPException(status_code=404, detail="Pharmacist not found in the pharmacy")

    # Remove the pharmacist by name from the list
    updated_pharmacists = [pharmacist for pharmacist in pharmacists if pharmacist.get('username') != pharmacist_username]

    # Update the pharmacy document
    await collection_name.update_one(
        {"name": pharmacy_name},
        {"$set": {"pharmacists": updated_pharmacists}}
    )

    return {"message": "Pharmacist removed successfully"}