from bson import ObjectId
from config.database import collection_name , drugs_collection , pharmacy_test
from  models.mpharmacy import Pharmacy
from schema.pharmacy import pharmaciesEntity,pharmacyEntity

class PharmacyDAO:
    @staticmethod
    async def get_all_pharmacies2() -> list[Pharmacy]:
        pharmacies = await pharmacy_test.find().to_list(1000)
        print(pharmacies)
        return pharmaciesEntity(pharmacies)
    
    @staticmethod
    async def create_pharmacy(pharmacy: Pharmacy):

        pharmacy_dict = pharmacy.dict()
        for drug_name in pharmacy_dict['drugs']:
            
            drug_exists = await drugs_collection.find_one({"drugName": {"$regex": f"^{drug_name}$", "$options": "i"}})

            
            if not drug_exists:
                raise ValueError(f"Drug with name {drug_name} does not exist in the drugs collection")

        # Insert the pharmacy into the collection
        pharmacy_id = await pharmacy_test.insert_one(pharmacy_dict)
        return {"id": str(pharmacy_id.inserted_id)}
    @staticmethod
    async def delete_pharmacy(pharmacy_id: str):
        """Delete pharmacy from the database based on the ID of the mongodb id of the pharmacy"""
        result = await pharmacy_test.delete_one({"_id": ObjectId(pharmacy_id)})
        return result
    
    @staticmethod
    async def pharmacy_exists(pharmacy_name):
        result = await pharmacy_test.find_one({"pharmacyName": f"{pharmacy_name}"})
        if result:
            return True
        else:
            return False
        
    

    


