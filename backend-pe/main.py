from fastapi import FastAPI 
from contextlib import asynccontextmanager
from routes import pharmacy, pharmacist , users , drugs, llm
# from middleware.errorHandler import error_handler
from config.database import setup_indexes
from fastapi.middleware.cors import CORSMiddleware
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

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(pharmacy.pharmacy, prefix="/api/pharmacy", tags=["pharmacy"])
app.include_router(users.user)
app.include_router(drugs.drug , prefix= "/api/drug" , tags=["drug"])
app.include_router(llm.bot , prefix="/api/chatbot" , tags=["chatbot"])
# app.include_router(pharmacist.pharmacist_router , prefix= "/api/pharmacist" , tags=["Pharmacist"])
# app.middleware("http")(error_handler)


# if __name__ == "__main__":
#     uvicorn.run(app,host= '0.0.0.0' , port= 8000)