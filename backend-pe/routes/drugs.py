from fastapi import APIRouter

from models.mpharmacy import Pharmacy
from config.database import collection_name
from schema.pharmacy import pharmacyEntity, pharmaciesEntity
from bson import ObjectId



pharmacy = APIRouter()


@pharmacy.get("/")
async def get_all_pharmacies():
    pharmacies = pharmaciesEntity(collection_name.find())
    return pharmacies


@pharmacy.post("/")
async def add_pharmacy(pharmacy: Pharmacy):
    collection_name.insert_one(dict(pharmacy))
