from fastapi import APIRouter, HTTPException
from models.mpharmacy import Pharmacy
from models.mpharmacist import Pharmacist
from models.mdrugs import Drug
from config.database import collection_name
from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from bson import ObjectId
from models.mlocation import Location
from geopy import distance
from typing import List, Optional

pharmacy = APIRouter()


# Return all pharmacies in the mdb
@pharmacy.get("/all")
async def get_all_pharmacies():
    pharmacies = await collection_name.find().to_list(1000)
    print(pharmaciesEntity(pharmacies))
    return pharmaciesEntity(pharmacies)


@pharmacy.get("/search_drug")
async def search_drug(drug_name: str, user_lat: float, user_lon: float):
    # Fetch all pharmacies that have the specified drug
    pharmacies = await collection_name.find({"drugs.name": drug_name}).to_list(1000)

    if not pharmacies:
        raise HTTPException(status_code=404, detail="No pharmacies found with the specified drug")

    # Calculate distance from user location to each pharmacy and sort
    for pharmacy in pharmacies:
        pharmacy_location = (pharmacy["location"]["latitude"], pharmacy["location"]["longitude"])
        user_loc = (user_lat, user_lon)
        pharmacy["distance"] = distance.distance(pharmacy_location, user_loc).km

    # Sort pharmacies by distance
    sorted_pharmacies = sorted(pharmacies, key=lambda x: x["distance"])[:5]

    return pharmaciesEntity(sorted_pharmacies)  # Pass sorted_pharmacies to the entity function


# add a drug to the pharmacy
@pharmacy.post("/{pharmacy_name}/add_drug")
async def add_drug_to_pharmacy(pharmacy_name: str, drug: Drug):
    # Fetch the pharmacy document by its name
    pharmacy = await collection_name.find_one({"name": pharmacy_name})
    if not pharmacy:
        raise HTTPException(status_code=404, detail="Pharmacy not found")

    # Append the new drug
    if "drugs" not in pharmacy:
        pharmacy["drugs"] = [drug.dict()]
    else:
        pharmacy["drugs"].append(drug.dict())

    # Update the pharmacy document
    await collection_name.update_one(
        {"name": pharmacy_name},
        {"$set": {"drugs": pharmacy["drugs"]}}
    )

    return {"message": "Drug added successfully"}


# create a pharmacy in mdb
@pharmacy.post("/create")
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


