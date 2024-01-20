from bson import ObjectId
from config.database import collection_name
from  models.mpharmacy import Pharmacy
from models.mdrugs import Drug
from schema.pharmacy import pharmaciesEntity,pharmacyEntity
from fastapi import HTTPException



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
    async def add_drug_pharmacy():
        pass

    @staticmethod
    async def delete_drug_pharmacy():
        pass


