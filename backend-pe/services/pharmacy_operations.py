from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from geopy import distance
from fastapi import APIRouter, HTTPException
from config.database import collection_name
from fastapi import APIRouter, HTTPException
from models.mpharmacy import Pharmacy
from models.mpharmacist import Pharmacist
from models.mdrugs import Drug
from config.database import collection_name
from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from bson import ObjectId
from models.mlocation import Location
from typing import List, Optional

def get_all_service(pharmacies):

    """
    Return all pharmacies in the database
    """
    print(pharmaciesEntity(pharmacies))
    return pharmaciesEntity(pharmacies)




async def search_for_drug_service(drug_name, user_lat, user_lon):
    """
    Takes three arguments : drug name , user lat and long , then it returns the top 5 pharmacies 
    based on the distance method of the geopy
    """
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

    return pharmaciesEntity(sorted_pharmacies)





async def add_drug_service(pharmacy_name, drug):
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



async def add_pharmacy_service(pharmacy):
    pharmacy_dict = pharmacy.dict()
    pharmacy_id = await collection_name.insert_one(pharmacy_dict)
    return {"id": str(pharmacy_id.inserted_id)}