from fastapi import FastAPI
from routes import pharmacy
from middleware.errorHandler import error_handler

app = FastAPI()

app.include_router(pharmacy.pharmacy, prefix="/api/pharmacy", tags=["pharmacy"])

app.middleware("http")(error_handler)