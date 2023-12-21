from fastapi import APIRouter, HTTPException
from models.muser import User as User
from config.database import users_collection
from passlib.context import CryptContext
from fastapi import Depends, HTTPException
from fastapi.security import OAuth2PasswordBearer, OAuth2PasswordRequestForm
import jwt


user_router = APIRouter()
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")


SECRET_KEY = "your_jwt_secret"
ALGORITHM = "HS256"

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="token")

@user_router.post("/register")
async def register_user(user: User):
    # Check if user already exists
    existing_user = await users_collection.find_one({"email": user.email})
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    # Hash the password
    hashed_password = pwd_context.hash(user.password)
    user.password = hashed_password

    # Store the user in the database
    await users_collection.insert_one(user.dict())

    return {"message": "User registered successfully"}



@user_router.post("/token")
async def login(form_data: OAuth2PasswordRequestForm = Depends()):
    user = await users_collection.find_one({"email": form_data.username})
    if not user or not pwd_context.verify(form_data.password, user['password']):
        raise HTTPException(status_code=401, detail="Incorrect username or password")

    # Create a token
    token = jwt.encode({"sub": user["email"]}, SECRET_KEY, algorithm=ALGORITHM)
    return {"access_token": token, "token_type": "bearer"}

# Dependency for getting the current user
async def get_current_user(token: str = Depends(oauth2_scheme)):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        user = await users_collection.find_one({"email": payload["sub"]})
        if not user:
            raise HTTPException(status_code=401, detail="Invalid authentication credentials")
        return user
    except jwt.PyJWTError:
        raise HTTPException(status_code=401, detail="Invalid token")