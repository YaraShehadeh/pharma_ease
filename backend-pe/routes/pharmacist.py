from fastapi import APIRouter, HTTPException
from models.mpharmacist import Pharmacist as PharmacistModel
from config.database import collection_name
from bson import ObjectId
from schema.pharmacist import pharmacistEntity

pharmacist_router = APIRouter()

# Assuming there's a field in the pharmacist document that links to the pharmacy they work at.
# For example: "pharmacy_id": "some_pharmacy_object_id"
@pharmacist_router.get("/{pharmacist_name}")
async def get_pharmacist_pharmacy(pharmacist_name: str):
    # Search for a pharmacy where one of the pharmacists has the given username
    pharmacy = await collection_name.find_one({"pharmacists.username": pharmacist_name})
    
    if not pharmacy:
        raise HTTPException(status_code=404, detail="Pharmacy not found for the pharmacist")

    # Extract the pharmacist's details from the list of pharmacists in the pharmacy
    print(pharmacy)
    pharmacist_details = pharmacy["pharmacists"][0]
    print(pharmacist_details)


    if not pharmacist_details:
        raise HTTPException(status_code=404, detail="Pharmacist details not found")

    return {
        "pharmacy": {
            "id": str(pharmacy["_id"]),
            "name": pharmacy["name"],
            "email": pharmacy["email"],
            "description": pharmacy["description"],
            "location": pharmacy["location"]
        }
    }