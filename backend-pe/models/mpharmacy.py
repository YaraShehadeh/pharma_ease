                    from pydantic import BaseModel , Field
                    from typing import List
                    from models.mdrugs import Drug
                    from models.mlocation import Location
                    from models.mpharmacist import Pharmacist

                    class Pharmacy(BaseModel):
                        name: str = Field(..., description= "Please add the pharmacy name", unique = True)
                        email: str = Field(..., description= "Please add the pharamcy email" , unique = True)
                        description: str = Field(..., description= "Please add the pharamcy description")
                        location: Location = Field(..., description= "Please add the pharamcy location", unique = True)
                        drugs: List[Drug] = Field(..., description="Please add drugs to the pharmacy")
                        pharmacists: List[Pharmacist] = Field(..., description="please enter pharmacist details")
