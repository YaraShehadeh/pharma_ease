from models.mdrugs import Drug as DrugModel
from typing import List

def drugEntity(item: dict) -> DrugModel:
      return DrugModel(
        drugName = item.get("drugName"),
        drugDescription = item["drugDescription"],
        drugBarcode = item.get("drugBarcode"),
        drugPerscription = item["drugPerscription"],
        drugInteractions = item["drugInteractions"],
        drugImage = item["drugImage"],
        holdingPharmacies = item["holdingPharmacies"],
        drugAlternatives = item["drugAlternatives"],
        Allergies = item["Allergies"]
    )

def drugsEntity(entity: List[dict]) -> list[DrugModel]:
    return [drugEntity(item) for item in entity]
