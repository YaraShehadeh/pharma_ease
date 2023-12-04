from fastapi import FastAPI 
from contextlib import asynccontextmanager
from routes import pharmacy, pharmacist , users
from middleware.errorHandler import error_handler
from config.database import setup_indexes
from fastapi.middleware.cors import CORSMiddleware


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
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
# app.middleware("http")(error_handler)