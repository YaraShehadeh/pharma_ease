from datetime import datetime


def pharmacyEntity(item) -> dict:

    opening_hours = item.get("pharmacyOpeningHours", "")
    if opening_hours:
        opening_hours = opening_hours.strftime('%Y-%m-%dT%H:%M:%SZ') if isinstance(opening_hours, datetime) else opening_hours

    closing_hours = item.get("pharmacyClosingHours", "")
    if closing_hours:
        closing_hours = closing_hours.strftime('%Y-%m-%dT%H:%M:%SZ') if isinstance(closing_hours, datetime) else closing_hours
    return {
        "id": str(item["_id"]),
        "pharmacyName": item["pharmacyName"],
        "pharmacyemail": item["pharmacyemail"],
        "pharmacyDescription": item.get("pharmacyDescription", ""),
        "pharmacyImage": item.get("pharmacyImage", ""),
        "pharmacyArea": item.get("pharmacyArea", ""),
        "pharmacyDistance": item.get("pharmacyDistance", ""),
        "pharmacyOpeningHours": opening_hours,
        "pharmacyClosingHours": closing_hours,
        "pharmacyPhoneNumber": item.get("pharmacyPhoneNumber", ""),
        "location": {
            "longitude": float(item["location"]["longitude"]),
            "latitude": float(item["location"]["latitude"])
        },
        "drugs": [
            {
                "drugName": drug["drugName"], 
                "drugDescription": drug["drugDescription"],
                "drugBarcode": drug["drugBarcode"],
                "drugPerscription": drug["drugPerscription"],
                "drugInteractions": drug["drugInteractions"],
                "drugImage": drug["drugImage"],
                "conflictingDrugs": drug["conflictingDrugs"]
            } for drug in item["drugs"]
        ],
        "pharmacists": [{"first_name": pharmacist["first_name"], "last_name": pharmacist["last_name"],
                         "username": pharmacist["username"], "password": pharmacist["password"]} for pharmacist in item.get("pharmacists", [])]
    }

def pharmaciesEntity(entity) -> list:
    return [pharmacyEntity(item) for item in entity]