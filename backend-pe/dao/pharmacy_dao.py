from bson import ObjectId
from config.database import collection_name
from  models.mpharmacy import Pharmacy
from schema.pharmacy import pharmaciesEntity,pharmacyEntity

class PharmacyDAO:
    @staticmethod
    async def get_all_pharmacies2() -> list[Pharmacy]:
        pharmacies = await collection_name.find().to_list(1000)
        print(pharmaciesEntity(pharmacies))
        return pharmaciesEntity(pharmacies)
    
    @staticmethod
    async def create_pharmacy(pharmacy:Pharmacy):
        """Create pharmacy with the pydantic model defined in /models"""
        pharmacy_dict = pharmacy.dict()
        pharmacy_id = await collection_name.insert_one(pharmacy_dict)
        return {"id": str(pharmacy_id.inserted_id)}
    
    @staticmethod
    async def delete_pharmacy(pharmacy_id: str):
        """Delete pharmacy from the database based on the ID of the mongodb id of the pharmacy"""
        result = await collection_name.delete_one({"_id": ObjectId(pharmacy_id)})
        return result
    
    @staticmethod
    async def pharmacy_exists(pharmacy_name):
        result = await collection_name.find_one({"pharmacyName": f"{pharmacy_name}"})
        if result:
            return True
        else:
            return False
        
    

    


