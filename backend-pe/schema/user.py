def UserEntity(item) -> dict:
    return{
        "id": str(item["_id"]),
        "name": str(item["name"]),
        "email": str(item["email"]),
        "password": str(item["password"]),
        "allergies": {
            "type": item["allergies"]["type"]
        }
    }