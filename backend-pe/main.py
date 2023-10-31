from fastapi import FastAPI
from routes import pharmacy, pharmacist
from middleware.errorHandler import error_handler
from config.database import setup_indexes

app = FastAPI()

@app.on_event('startup')
async def startup_event():
    await setup_indexes()
app.include_router(pharmacy.pharmacy, prefix="/api/pharmacy", tags=["pharmacy"])
app.include_router(pharmacist.pharmacist_router , prefix= "/api/pharmacist" , tags=["Pharmacist"])
app.middleware("http")(error_handler)