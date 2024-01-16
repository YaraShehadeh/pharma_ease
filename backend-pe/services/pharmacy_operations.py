from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from geopy import distance
from fastapi import APIRouter, HTTPException, Depends
from config.database import collection_name
from fastapi import APIRouter, HTTPException
from models.mpharmacy import Pharmacy
from models.mpharmacist import Pharmacist
from models.mdrugs import Drug
from config.database import collection_name, pharmacy_test , drugs_collection
from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from bson import ObjectId
from models.mlocation import Location
from models.muser import User
from typing import List, Optional , Union
import re


def get_all_service(pharmacies):

    """
    Return all pharmacies in the database
    """
    print(pharmaciesEntity(pharmacies))
    return pharmaciesEntity(pharmacies)




# async def search_for_drug_service(drug_name, user_lat, user_lon):
#     """
#     Takes three arguments : drug name , user lat and long , then it returns the top 5 pharmacies
#     based on the distance method of the geopy
#     """
#     pharmacies = await collection_name.find({"drugs.name": drug_name}).to_list(1000)
#     if not pharmacies:
#         raise HTTPException(status_code=404, detail="No pharmacies found with the specified drug")

#     # Calculate distance from user location to each pharmacy and sort
#     for pharmacy in pharmacies:
#         pharmacy_location = (pharmacy["location"]["latitude"], pharmacy["location"]["longitude"])
#         user_loc = (user_lat, user_lon)
#         pharmacy["distance"] = distance.distance(pharmacy_location, user_loc).km

#     # Sort pharmacies by distance
#     sorted_pharmacies = sorted(pharmacies, key=lambda x: x["distance"])[:5]

#     return pharmaciesEntity(sorted_pharmacies)




# # Function to search for multiple drugs
# async def search_for_drugs_service(drug_names: List[str], drug_barcode,user_lat: float, user_lon: float):
#     """
#     Takes a list of drug names along with user's latitude and longitude,
#     then returns the top 5 pharmacies based on the distance.
#     """
#     flag = False

#     if drug_names 

#     if not drug_names:
#         raise HTTPException(status_code=400, detail="No drug names provided")

#     # Find pharmacies that have any of the specified drugs
#     query = {"drugs.drugName": {"$in": [re.compile(r'^{}$'.format(drug_name), re.IGNORECASE) for drug_name in drug_names]}}
#     # query = {"drugs.drugName": {"$in": drug_names}}
#     pharmacies = await collection_name.find(query).to_list(1000)

    
#     if not pharmacies:
#         raise HTTPException(status_code=404, detail="No pharmacies found with the specified drugs")

    
#     for pharmacy in pharmacies:
#         pharmacy_location = (pharmacy["location"]["latitude"], pharmacy["location"]["longitude"])
#         user_loc = (user_lat, user_lon)
#         pharmacy["distance"] = distance.distance(pharmacy_location, user_loc).km

#     sorted_pharmacies = sorted(pharmacies, key=lambda x: x["distance"])[:5]

#     return pharmaciesEntity(sorted_pharmacies)



# async def search_for_drugs_service(drug_names: Union[List[str], None], drug_barcode: Union[str, None], user_lat: float, user_lon: float, current_user: Optional[User] = None) -> dict:
#     """
#     Takes a list of drug names or a drug barcode along with user's latitude and longitude,
#     then returns the top 5 pharmacies based on the distance, along with an allergy warning if applicable.
#     """
#     if not drug_names and not drug_barcode:
#         raise HTTPException(status_code=400, detail="No drug names or barcode provided")

#     query = {}
#     if drug_names:
#         query["drugs.drugName"] = {"$in": [re.compile(r'^{}$'.format(drug_name), re.IGNORECASE) for drug_name in drug_names]}
#     elif drug_barcode:
#         query["drugs.drugBarcode"] = re.compile(r'^{}$'.format(drug_barcode), re.IGNORECASE)

#     pharmacies = await collection_name.find(query).to_list(1000)
#     allergy_warning = "Warning: Some drugs in this pharmacy contain ingredients you are allergic to."

#     if current_user:
#         for pharmacy in pharmacies:
#             for drug in pharmacy["drugs"]:
#                 if any(allergy.type in drug["Allergies"] for allergy in current_user.allergies):
#                     allergy_warning = "Warning: The drug you are searching for contain ingredients you are allergic to."
#                     break  # Break the inner loop if any allergy is found
#             if allergy_warning:
#                 break  # Break the outer loop if any allergy is found

#     if not pharmacies:
#         raise HTTPException(status_code=404, detail="No pharmacies found with the specified drugs or barcode")

#     # Calculate distance and sort pharmacies
#     for pharmacy in pharmacies:
#         pharmacy_location = (pharmacy["location"]["latitude"], pharmacy["location"]["longitude"])
#         user_loc = (user_lat, user_lon)
#         pharmacy["distance"] = distance.distance(pharmacy_location, user_loc).km

#     sorted_pharmacies = sorted(pharmacies, key=lambda x: x["distance"])[:5]

#     return {
#         "pharmacies": pharmaciesEntity(sorted_pharmacies),
#         "allergy_warning": allergy_warning
#     }



async def search_for_drugs_service(drug_names: Union[List[str], None], 
                                   drug_barcode: Union[str, None], 
                                   user_lat: float, 
                                   user_lon: float, 
                                   current_user: Optional[User] = None) -> dict:
    """
    Takes a list of drug names or a drug barcode along with user's latitude and longitude,
    then returns the top 5 pharmacies based on the distance, along with an allergy warning if applicable.
    """
    if not drug_names and not drug_barcode:
        raise HTTPException(status_code=400, detail="No drug names or barcode provided")

    matching_drug_names = []
    if drug_barcode:
        # Search for drug by barcode
        drug = await drugs_collection.find_one({"drugBarcode": drug_barcode})
        if drug:
            matching_drug_names.append(drug['drugName'])
    elif drug_names:
        # Search for drugs by name
        for name in drug_names:
            drug = await drugs_collection.find_one({"drugName": re.compile(r'^{}$'.format(name), re.IGNORECASE)})
            if drug:
                matching_drug_names.append(drug['drugName'])

    if not matching_drug_names:
        raise HTTPException(status_code=404, detail="No matching drugs found")

    # Query pharmacies that have these drugs
    pharmacies = await pharmacy_test.find({"drugs": {"$in": matching_drug_names}}).to_list(1000)
    if not pharmacies:
        raise HTTPException(status_code=404, detail="No pharmacies found with the specified drugs")

    allergy_warning = None
    if current_user:
        # Check for allergies
        allergy_warning = await check_allergies(current_user, matching_drug_names)

    # Calculate distance and sort pharmacies
    for pharmacy in pharmacies:
        pharmacy_location = (pharmacy["location"]["latitude"], pharmacy["location"]["longitude"])
        user_loc = (user_lat, user_lon)
        pharmacy["distance"] = distance.distance(pharmacy_location, user_loc).km

    sorted_pharmacies = sorted(pharmacies, key=lambda x: x["distance"])[:5]

    return {
        "pharmacies": pharmaciesEntity(sorted_pharmacies),
        "allergy_warning": allergy_warning
    }



async def check_allergies(current_user: User, drug_names: List[str]) -> Optional[str]:
    """
    Checks if any of the drugs (by name) contain ingredients the user is allergic to.
    Returns an allergy warning message if applicable, otherwise None.
    """
    for drug_name in drug_names:
        # Find the drug by name
        drug = await drugs_collection.find_one({"drugName": drug_name})
        if not drug:
            continue

        # Check if there's an overlap between user allergies and drug allergies
        if any(allergy in drug.get("Allergies", []) for allergy in current_user.allergies):
            return f"Warning: The drug {drug_name} contains ingredients you are allergic to."

    # No allergies found
    return None


async def search_for_nearest_pharmacies_service(user_lat: float, user_lon: float) -> list[Pharmacy]:
    """
    Takes user's latitude and longitude and returns the top 5 nearest pharmacies based on the distance.
    """
    pharmacies = await collection_name.find().to_list(1000)

    if not pharmacies:
        raise HTTPException(status_code=404, detail="No pharmacies found")

    for pharmacy in pharmacies:
        pharmacy_location = (pharmacy["location"]["latitude"], pharmacy["location"]["longitude"])
        user_loc = (user_lat, user_lon)
        pharmacy["distance"] = distance.distance(pharmacy_location, user_loc).km

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