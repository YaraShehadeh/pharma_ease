# import motor.motor_asyncio

# uri = "mongodb+srv://admin:admin@cluster0.7p0u15r.mongodb.net/?retryWrites=true&w=majority"
# client = motor.motor_asyncio.AsyncIOMotorClient(uri)

# db = client.pharmacy_db
# collection_name = db["pharmacy"]



import motor.motor_asyncio

uri = "mongodb+srv://admin:admin@cluster0.7p0u15r.mongodb.net/?retryWrites=true&w=majority"
client = motor.motor_asyncio.AsyncIOMotorClient(uri)

db = client.pharmacy_db
collection_name = db["pharmacy"]
users_collection = db["users"]

async def setup_indexes():
    # Create unique indexes
    await collection_name.create_index("name", unique=True)
    await collection_name.create_index("email", unique=True)
    await collection_name.create_index("location", unique=True)
    await collection_name.create_index("pharmacists.username", unique=True)
    
