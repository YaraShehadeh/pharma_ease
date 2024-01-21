from pydantic import BaseModel , Field
from typing import List
from models.mallergies import Allergie
from models.mlocation import Location
from pydantic import BaseModel, EmailStr


class User(BaseModel):
    name: str = Field(..., description= "Please enter your name")
    email: str = Field(...,description= "Please enter your email")
    password: str = Field(...,description= "Please enter your password")
    dob: str = Field(...,description= "Please enter your data of birth")
    user_location: Location= Field(..., description="Please allow the location services")
    allergies: List[Allergie] = Field(..., description= "Please enter your allergies")


# from pydantic import BaseModel, EmailStr

# class User(BaseModel):
#     username: str
#     email: EmailStr
#     password: str
