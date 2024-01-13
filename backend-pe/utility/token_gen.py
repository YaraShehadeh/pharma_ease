from datetime import datetime, timedelta
from jose import JWTError, jwt
from config.database import collection_name
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

async def get_user(username: str):
    # Assuming 'collection_name' is your MongoDB collection for users
    user = await collection_name.find_one({"username": username})
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
        username: str = payload.get("sub")
        if username is None:
            raise credentials_exception
    except JWTError:
        raise credentials_exception

    user = get_user(username)
    if user is None:
        raise credentials_exception
    return user


