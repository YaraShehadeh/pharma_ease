import motor.motor_asyncio

uri = "mongodb+srv://admin:admin@cluster0.7p0u15r.mongodb.net/?retryWrites=true&w=majority"
client = motor.motor_asyncio.AsyncIOMotorClient(uri)

db = client.pharmacy_db
collection_name = db["pharmacy"]
