from pydantic import BaseModel, Field
from typing import List

class Base_Pharmacy(BaseModel):
    name: str = Field(..., description= "Please add the pharmacy name", unique = True)
    email: str = Field(..., description= "Please add the pharamcy email" , unique = True)
    description: str = Field(..., description= "Please add the pharamcy description")
    location: 'Location' = Field(..., description= "Please add the pharamcy location", unique = True)
    drugs: List['Drug'] = Field(..., description="Please add drugs to the pharmacy")
    pharmacists: List['Pharmacist'] = Field(..., description="please enter pharmacist details")



class Allergie(BaseModel):
    type: str
    name: str


class Pharmacist(BaseModel):
    first_name: str = Field(..., description="Please enter your first name")
    last_name: str = Field(..., description="Please enter your last name")
    username: str = Field(...,description= "Please enter your username")
    password: str = Field(..., description="Please enter your password")


class Location(BaseModel):
    longitude: str
    latitude: str


class Drug(BaseModel):
    name: str
    description: str


class Base_User(BaseModel):
    name: str = Field(..., description= "Please enter your name")
    email: str = Field(...,description= "Please enter your email")
    password: str = Field(...,description= "Please enter your password")
    dob: str = Field(...,description= "Please enter your data of birth")
    user_location: Location= Field(..., description="Please allow the location services")
    allergies: List[Allergie] = Field(..., description= "Please enter your allergies")