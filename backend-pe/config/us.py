from motor import motor_asyncio
import motor

url = "mongodb+srv://admin:admin@cluster0.7p0u15r.mongodb.net/?retryWrites=true&w=majority"
client = motor_asyncio.AsyncIOMotorClient(url)




db = client.test_users
test_pharmacy = db["test_pharmacy"]
