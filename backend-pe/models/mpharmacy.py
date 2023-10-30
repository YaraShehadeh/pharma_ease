from pydantic import BaseModel , Field
from typing import List
from models.mdrugs import Drug
from models.mlocation import Location


class Pharmacy(BaseModel):
    name: str = Field(..., description= "Please add the pharmacy name")
    email: str = Field(..., description= "Please add the pharamcy email")
    description: str = Field(..., description= "Please add the pharamcy description")
    location: Location = Field(..., description= "Please add the pharamcy location")
    drugs: List[Drug] = Field(..., description="Please add drugs to the pharmacy")
