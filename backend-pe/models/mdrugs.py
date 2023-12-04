from pydantic import BaseModel


class Drug(BaseModel):
    name: str
    description: str
    barcode :str