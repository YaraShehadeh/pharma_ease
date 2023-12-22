from pydantic import BaseModel , validator
from typing import List, Optional


class Drug(BaseModel):
    drugName: Optional[str] = None
    drugDescription: str
    drugBarcode: Optional[str] = None
    drugPerscription: str
    drugInteractions: str
    drugImage: List[str]
    conflictingDrugs: List[str]

    @validator('drugBarcode', always=True)
    def check_at_least_one_field_is_provided(cls, v, values, **kwargs):
        if not v and not values.get('drugName'):
            raise ValueError('Either drugName or drugBarcode must be provided')
        return v