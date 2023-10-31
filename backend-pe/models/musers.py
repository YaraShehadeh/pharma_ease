from pydantic import BaseModel , Field
from models.mlocation import Location

class User(BaseModel):
    first_name: str = Field(description="Please enter your first name")
    last_name: str = Field(description="Please enter your last name")
    email: str=Field(..., description="Please enter your email")
    password: str=Field(...,description="Please enter your password")
    age: int=Field(description="Please enter your age")
    user_location: Location= Field(..., description="Please allow the location services")
    
