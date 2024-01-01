from models.mdrugs import Drug as DrugModel
from typing import List
import re

def filter_wrong_medicines(medicine: str, medicines: List[List[DrugModel]],filter_type) -> List[List[DrugModel]]:
    medicine = medicine.lower()  
    filtered_medicines = []  

    for sublist in medicines:
        sublist_filtered = []
        for drug in sublist:
            drug_dict = drug.dict()  
            if re.findall(f"^{medicine}", drug_dict[f"{filter_type}"].lower()):
                sublist_filtered.append(drug) 
        if sublist_filtered:  
            filtered_medicines.append(sublist_filtered)

    return filtered_medicines

def drugEntity(item: dict) -> DrugModel:
    return DrugModel(
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

def drugsEntity(entity: List[dict]) -> DrugModel:
    return [drugEntity(item) for item in entity]
