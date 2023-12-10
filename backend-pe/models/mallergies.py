from pydantic import BaseModel

class Allergie(BaseModel):
    type: str
    name: str