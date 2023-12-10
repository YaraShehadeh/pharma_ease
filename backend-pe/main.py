from fastapi import FastAPI 
from contextlib import asynccontextmanager
from routes import pharmacy, pharmacist , users
# from middleware.errorHandler import error_handler
from config.database import setup_indexes
import uvicorn 


@asynccontextmanager
async def lifespan(app:FastAPI):
    await setup_indexes()
    try:
        yield
    finally:
        pass

# @app.on_event('startup')
# async def startup_event():
    


app = FastAPI(lifespan=lifespan)
app.include_router(pharmacy.pharmacy, prefix="/api/pharmacy", tags=["pharmacy"])
app.include_router(users.user_router, prefix= "/api/user", tags=["user"])
# app.include_router(pharmacist.pharmacist_router , prefix= "/api/pharmacist" , tags=["Pharmacist"])
# app.middleware("http")(error_handler)


# if __name__ == "__main__":
#     uvicorn.run(app,host= '0.0.0.0' , port= 8000)