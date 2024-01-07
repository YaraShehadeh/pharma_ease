import pinecone
# from utils import *
import os
from dotenv import load_dotenv
load_dotenv()
class PinecoinOperations:

    def __init__(self):

        pinecone.init(
            api_key=os.getenv("PINECONE_API_KEY"),
            environment="gcp-starter"
        )
        self.index = None

    def create_index(self, indexName=os.getenv("PINECONE_INDEX_NAME")) :
        indexes = pinecone.list_indexes()

        if indexName not in indexes:
            print(f"creating an index {indexName}")
            pinecone.create_index(indexName, dimension=1536, metric="cosine", pods=1, pod_type='p1.x2')
        if (indexes == 0):
            print("creating default index")
            pinecone.create_index(indexName, dimension=1536, metric="cosine", pods=1, pod_type='p1.x2')
        else:
            print(f"{indexName} already exists")

    def describe_indexs(self):
        return self.describe_index()

    def delete_index(self, index_name):
        pinecone.delete_index(index_name)
        print(f"{index_name} index deleted")

    def status_index(self, name):
        index = pinecone.Index(name)
        return index.describe_index_stats()







