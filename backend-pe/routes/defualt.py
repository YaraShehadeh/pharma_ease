from fastapi import APIRouter

defualt= APIRouter()

@defualt.get("/")
async def res():
    return "Please redirect to 127.0.0.1:8000/docs to test the api"