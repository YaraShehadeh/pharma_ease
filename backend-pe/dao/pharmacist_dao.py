from bson import ObjectId
from config.database import collection_name
from  models.mpharmacy import Pharmacy
from models.mdrugs import Drug
from schema.pharmacy import pharmaciesEntity,pharmacyEntity
from fastapi import HTTPException
from pymongo import ReturnDocument



class PharmacistDAO:
    

    @staticmethod
    async def drug_exists(drugName: Drug,pharmacy_name):

        try:
            result = await collection_name.find_one({"$and": [{"pharmacyName": {"$regex": f"^{pharmacy_name}$", "$options": "i"}},
        {"drugs.drugName": {"$regex": f"^{drugName.drugName}$", "$options": "i"}} ]})
            if result is None:
                return 0
            else:
                return 1
        except Exception as e:
            print(e)


        


    @staticmethod
    async def add_drug_pharmacy(drug: Drug, pharmacy_name: str):
        # Update the pharmacy document to add the drug to the drugs array
        updated_pharmacy = await collection_name.find_one_and_update(
            {"pharmacyName": pharmacy_name},
            {"$addToSet": {"drugs": drug.dict()}},
            return_document=ReturnDocument.AFTER
        )
        if updated_pharmacy is None:
            raise ValueError("Pharmacy not found")

        return updated_pharmacy
    @staticmethod
    async def delete_drug_pharmacy():
        pass


