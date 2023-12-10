def UserEntity(item) -> dict:
    return{
        "id": str(item["_id"]),
        "email": str(item["email"]),
        "password": str(item["password"]),
        "dob": str(item["dob"]),
        "location":{
            "longitude": item["location"]["longitude"],
            "latitude": item["location"]["latitude"]
        },
        "allergies": {
            "name": item["allergies"]["name"],
            "type": item["allergies"]["type"]
        }
    }