from pydantic import BaseModel
from typing import List


class Drug(BaseModel):
    drugName: str
    drugDescription: str
    drugBarcode: str
    drugPerscription: str
    drugInteractions: str
    drugImage: List[str]
    conflictingDrugs: List[str]