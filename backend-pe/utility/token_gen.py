from datetime import datetime, timedelta
from jose import JWTError, jwt
from config.database import users_collection
from models.muser import User

SECRET_KEY = "JvoCa9FzL6fD95Ve0AwtqGN3A1fKVAnDBknu88wdfi4"
ALGORITHM = "HS256"

def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    if expires_delta:
        expire = datetime.utcnow() + expires_delta
    else:
        expire = datetime.utcnow() + timedelta(minutes=15)
    to_encode.update({"exp": expire})
    encoded_jwt = jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)
    return encoded_jwt

async def get_user(email: str):
    # Assuming 'collection_name' is your MongoDB collection for users
    user = await users_collection.find_one({"email": email})
    if user:
        return User(**user)  # Replace 'UserInDB' with your Pydantic model
    return None


from fastapi import Depends, HTTPException, Security
from fastapi.security import OAuth2PasswordBearer 
from jose import JWTError, jwt
from pydantic import ValidationError

oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/token")

async def get_current_user(token: str = Depends(oauth2_scheme)):
    credentials_exception = HTTPException(
        status_code=401,
        detail="Could not validate credentials",
        headers={"WWW-Authenticate": "Bearer"},
    )
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        email: str = payload.get("sub")
        if email is None:
            print("email not found in token")  # Debugging
            raise credentials_exception
    except JWTError as e:
        print(f"JWT Error: {e}")  # Debugging
        raise credentials_exception

    user = await get_user(email)
    if user is None:
        print("User not found in database")  # Debugging
        raise credentials_exception
    return user



