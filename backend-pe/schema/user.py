def UserEntity(item) -> dict:
    return{
        "id": str(item["_id"]),
        "name": str(item["name"]),
        "email": str(item["email"]),
        "password": str(item["password"]),
        "dob": str(item["dob"]),
        "location":{
            "longitude": item["location"]["longitude"],
            "latitude": item["location"]["latitude"]
        },
        "allergies": {
            "type": item["allergies"]["type"]
        }
    }