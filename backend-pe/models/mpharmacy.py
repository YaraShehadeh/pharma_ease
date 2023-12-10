from pydantic import BaseModel , Field
from typing import List
from models.mdrugs import Drug
from models.mlocation import Location
from models.mpharmacist import Pharmacist

class Pharmacy(BaseModel):
    pharmacyName: str = Field(..., description= "Please add the pharmacy name", unique = True)
    pharmacyemail: str = Field(..., description= "Please add the pharamcy email" , unique = True)
    pharmacyDescription: str = Field(..., description= "Please add the pharamcy description")
    pharmacyImage: str = Field(..., description= "Please add the pharamcy image")
    pharmacyArea: str = Field(..., description= "Please add the pharamcy area")
    pharmacyDistance: str = Field(..., description= "Please add the pharamcy distance")
    pharmacyOpeningHours: str = Field(..., description= "Please add the pharamcy opening hours")
    pharmacyClosingHours: str = Field(..., description= "Please add the pharamcy closing hours")
    pharmacyPhoneNumber: str = Field(..., description= "Please add the pharamcy phone number")
    location: Location = Field(..., description= "Please add the pharamcy location", unique = True)
    drugs: List[Drug] = Field(..., description="Please add drugs to the pharmacy")
    pharmacists: List[Pharmacist] = Field(..., description="please enter pharmacist details")
