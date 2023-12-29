from fastapi import APIRouter, HTTPException
from config.database import drugs_collection
from schema.drugs import drugEntity
from models.mlocation import Location
from typing import List, Optional
from models.mdrugs import Drug

drug = APIRouter()



@drug.post("/create_drug")
async def create_drug(drug: Drug):
    drug_dict = drug.dict()
    drug_id = await drugs_collection.insert_one(drug_dict)
    return {"id":str(drug_id)}



@drug.get("/drugname/{drug_name}")
async def get_drug_by_name(drug_name: str) -> Drug:
    regex_pattern = f".*{drug_name}.*"  
    drug_cursor = drugs_collection.find({"drugName": {"$regex": regex_pattern, "$options": "i"}}) 
    drugs = await drug_cursor.to_list(length=None)
    if drugs:
        return [drugEntity(drug) for drug in drugs]  
    else:
        raise HTTPException(status_code=404, detail="Drug not found")
