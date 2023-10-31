from pydantic import BaseModel, Field


class Pharmacist(BaseModel):
    first_name: str = Field(..., description="Please enter your first name")
    last_name: str = Field(..., description="Please enter your last name")
    username: str = Field(...,description= "Please enter your username")
    password: str = Field(..., description="Please enter your password")
