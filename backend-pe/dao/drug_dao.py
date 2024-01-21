from config.database import collection_name 
import re



class DrugDAO:

    @staticmethod
    async def get_drugs(drug_name):
        regex_pattern = f"^{drug_name}.*"
        drug_cursor = collection_name.find({"drugs.drugName": {"$regex": regex_pattern, "$options": "i"}})
        drugs = await drug_cursor.to_list(length=None)

        return drugs
    

    @staticmethod
    async def get_exact_drug(drug_name):
        regex_pattern = f"^{re.escape(drug_name)}$"
        drug_cursor = collection_name.find({"drugs.drugName": {"$regex": regex_pattern, "$options": "i"}})
        drugs = await drug_cursor.to_list(length=None)
        return drugs