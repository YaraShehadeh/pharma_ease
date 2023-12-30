from fastapi import APIRouter, HTTPException
from config.database import drugs_collection , collection_name
from schema.drugs import drugEntity , drugsEntity , filter_wrong_medicines
from models.mlocation import Location
from typing import List, Optional , Union
from models.mdrugs import Drug

drug = APIRouter()



@drug.post("/create_drug")
async def create_drug(drug: Drug):
    drug_dict = drug.dict()
    drug_id = await drugs_collection.insert_one(drug_dict)
    return {"id":str(drug_id)}



@drug.get("/drugname/{drug_name}")
async def get_drug_by_name(drug_name: Union[str,None]) -> Drug:
    regex_pattern = f"^{drug_name}.*"
    # drug_cursor = drugs_collection.find({"drugName": {"$regex": regex_pattern, "$options": "i"}})
    drug_cursor = collection_name.find({"drugs.drugName": {"$regex": regex_pattern, "$options": "i"}})

    try:
        drugs = await drug_cursor.to_list(length=None)
        if drugs:
            # entity2 = [drug["drugs"] for drug in entity ]
            pre_processed_drugs = [drugsEntity(drug["drugs"]) for drug in drugs]
            post_processed_drugs = filter_wrong_medicines(drug_name,pre_processed_drugs)
            return post_processed_drugs
        else:
            raise HTTPException(status_code=404, detail="Drug not found")
    except Exception as e:
        print(e)
