# import motor.motor_asyncio

# uri = "mongodb+srv://admin:admin@cluster0.7p0u15r.mongodb.net/?retryWrites=true&w=majority"
# client = motor.motor_asyncio.AsyncIOMotorClient(uri)

# db = client.pharmacy_db
# collection_name = db["pharmacy"]
import motor.motor_asyncio

uri = "mongodb+srv://yaznzamel:admin@cluster0.pyodbqi.mongodb.net/?retryWrites=true&w=majority&tlsInsecure=true"
# uri = "mongodb+srv://admin:admin@cluster0.7p0u15r.mongodb.net/?retryWrites=true&w=majority"
client = motor.motor_asyncio.AsyncIOMotorClient(uri)

db = client.pharmacy_db
collection_name = db["pharmacy"]
users_collection = db["users"]
drugs_collection = db["drugs"]


async def setup_indexes():
    # Create unique indexes
    await collection_name.create_index("pharmacyName", unique=True)
    await collection_name.create_index("pharmacyemail", unique=True)
    await collection_name.create_index("location", unique=True)
    await collection_name.create_index("pharmacists.username", unique=True)