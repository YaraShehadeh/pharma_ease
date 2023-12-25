from pydantic import BaseModel, Field , validator
from typing import List
from models.mdrugs import Drug
from models.mlocation import Location
from models.mpharmacist import Pharmacist
from datetime import datetime

from config.database import collection_name

class Pharmacy(BaseModel):
    pharmacyName: str = Field(..., description="Please add the pharmacy name")
    pharmacyemail: str = Field(..., description="Please add the pharmacy email")
    pharmacyDescription: str = Field(..., description="Please add the pharmacy description")
    pharmacyImage: str = Field(..., description="Please add the pharmacy image")
    pharmacyArea: str = Field(..., description="Please add the pharmacy area")
    pharmacyDistance: str = Field(..., description="Please add the pharmacy distance")
    pharmacyOpeningHours: datetime = Field(..., description="Please add the pharmacy opening hours")
    pharmacyClosingHours: datetime = Field(..., description="Please add the pharmacy closing hours")
    pharmacyPhoneNumber: str = Field(..., description="Please add the pharmacy phone number")
    location: Location = Field(..., description="Please add the pharmacy location")
    drugs: List[Drug] = Field(..., description="Please add drugs to the pharmacy")
    pharmacists: List[Pharmacist] = Field(..., description="Please enter pharmacist details")

    @validator('pharmacyOpeningHours', 'pharmacyClosingHours', pre=True)
    def parse_date(cls, value):
        if value and isinstance(value, str):
            try:
                return datetime.strptime(value, '%Y-%m-%dT%H:%M:%SZ')
            except ValueError:
                raise ValueError("Incorrect date format, should be YYYY-MM-DDTHH:MM:SSZ")
        return value

    class Config:
        orm_mode = True

    def __init__(
        self,
        pharmacyName: str,
        pharmacyemail: str,
        pharmacyDescription: str,
        pharmacyImage: str,
        pharmacyArea: str,
        pharmacyDistance: str,
        pharmacyOpeningHours: str,
        pharmacyClosingHours: str,
        pharmacyPhoneNumber: str,
        location: Location,
        drugs: List[Drug],
        pharmacists: List[Pharmacist]
    ):
        super().__init__(
            pharmacyName=pharmacyName,
            pharmacyemail=pharmacyemail,
            pharmacyDescription=pharmacyDescription,
            pharmacyImage=pharmacyImage,
            pharmacyArea=pharmacyArea,
            pharmacyDistance=pharmacyDistance,
            pharmacyOpeningHours=pharmacyOpeningHours,
            pharmacyClosingHours=pharmacyClosingHours,
            pharmacyPhoneNumber=pharmacyPhoneNumber,
            location=location,
            drugs=drugs,
            pharmacists=pharmacists)
