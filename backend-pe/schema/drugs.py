from models.mdrugs import Drug 
from typing import List
import re

def filter_wrong_medicines(medicine: str, medicines: List[List[Drug]], filter_type) -> List[Drug]:
    medicine = medicine.lower()
    filtered_medicines = []

    #Filter based on the medicine being searched for
    for sublist in medicines:
        for drug in sublist:
            drug_dict = drug.dict()
            if medicine in drug_dict[f"{filter_type}"].lower():
                filtered_medicines.append(drug)

    #Convert names to lowercase, check and remove duplicates
    unique_medicines = []
    added_drug_names = set()
    for drug in filtered_medicines:
        drug_name_lower = drug.dict()[f"{filter_type}"].lower()
        if drug_name_lower not in added_drug_names:
            unique_medicines.append(drug)
            added_drug_names.add(drug_name_lower)

    return unique_medicines


def drugEntity(item: dict) -> Drug:
    return  Drug(
        drugName=item.get("drugName"),
        drugDescription=item["drugDescription"],
        drugBarcode=item["drugBarcode"],
        drugPerscription=item["drugPerscription"],
        drugInteractions=item["drugInteractions"],
        drugImage=item["drugImage"],
        holdingPharmacies=item["holdingPharmacies"],
        drugAlternatives=item["drugAlternatives"],
        Allergies=item["Allergies"]
    )
    

def drugsEntity(entity: List[dict]) -> Drug:
    return [drugEntity(item) for item in entity]
