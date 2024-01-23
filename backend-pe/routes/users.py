

from datetime import timedelta
from fastapi import APIRouter, HTTPException , Depends
from models.muser import User
from config.us import collection_name
from config.database import users_collection
from utility.hash_util import hash_password, verify_password
from utility.token_gen import create_access_token, get_current_user
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm


user = APIRouter(prefix= '/auth' , tags=['auth'])


@user.post("/register")
async def create_user(new_user: User):

    existing_user = await users_collection.find_one({"email": new_user.email})
    print(type(new_user))
    if existing_user:
        return "User already registred"

    hashed_password = hash_password(new_user.password)
    await users_collection.insert_one({**new_user.dict(), "password": hashed_password})
    print(hash_password)
    return "User created successfully."
    





oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")


async def authenticate_user(email, password):
    existing_user = await users_collection.find_one({"email": email})
    if existing_user and verify_password(password, existing_user["password"]):
        return existing_user
    return None




#verify the token 



@user.post("/token")
async def login_for_access_token(form_data: OAuth2PasswordRequestForm = Depends()) -> str:
    user = await authenticate_user(form_data.username, form_data.password)
    if not user:
        raise HTTPException(
            status_code=400, detail="Incorrect username or password"
        )
    access_token_expires = timedelta(minutes=30)
    access_token = create_access_token(
        data={"sub": user["email"]}, expires_delta=access_token_expires
    )
    return access_token
