from models.base_models import Base_Pharmacy
from pydantic import BaseModel


class Pharmacy(Base_Pharmacy):
    
    # Example of an additional field not in Base_Pharmacy
    additional_field: str = None

    def __init__(self, name: str, email: str, description: str, location, drugs, pharmacists, additional_field: str = None, **data):
        super().__init__(name=name, email=email, description=description, location=location, drugs=drugs, pharmacists=pharmacists, **data)
        self.additional_field = additional_field

    # Example of an additional method
    def save_to_database(self):
        # Code to save this Pharmacy instance to a database
        pass

    # Example of a static method
    @staticmethod
    def find_pharmacy_by_name(name: str):
        # Code to find a pharmacy by name from the database
        pass

    # Example of a class method
    @classmethod
    def create_from_dict(cls, data: dict):
        return cls(**data)
