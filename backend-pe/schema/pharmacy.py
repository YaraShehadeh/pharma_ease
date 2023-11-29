def pharmacyEntity(item) -> dict:
    return {
        "id": str(item["_id"]),
        "name": item["name"],
        "email": item["email"],
        "description": item.get("description", ""),
        "location": {
            "longitude": float(item["location"]["longitude"]),
            "latitude": float(item["location"]["latitude"])
        },
        "drugs": [{"name": drug["name"], "description": drug["description"]} for drug in item.get("drugs", [])],
        "pharmacists": [{"first_name": pharmacist["first_name"], "last_name": pharmacist["last_name"],
                         "username": pharmacist["username"], "password": pharmacist["password"]} for pharmacist in item.get("pharmacists", [])]
    }

def pharmaciesEntity(entity) -> list:
    return [pharmacyEntity(item) for item in entity]