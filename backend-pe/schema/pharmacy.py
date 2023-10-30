def pharmacyEntity(item) -> dict:
    return {
        "id": str(item["_id"]),
        "name": item["name"],
        "email": item["email"],
        "description": item.get("description", ""),
        "location": {
            "longitude": item["location"]["longitude"],
            "latitude": item["location"]["latitude"]
        },
        "drugs": [{"name": drug["name"], "description": drug["description"]} for drug in item.get("drugs", [])]
    }

def pharmaciesEntity(entity) -> list:
    return [pharmacyEntity(item) for item in entity]
