from typing import List

def pharmacistEntity(pharmacist) -> dict:
    return {
        "first_name": pharmacist["first_name"],
        "last_name": pharmacist["last_name"],
        "username": pharmacist["username"],
        "password": pharmacist["password"],
        "gender":pharmacist["gender"]
    }

def pharmacistsEntity(pharmacists: List[dict]) -> List[dict]:
    return [pharmacistEntity(pharmacist) for pharmacist in pharmacists]
