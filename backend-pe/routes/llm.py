from fastapi import APIRouter
from llm.langbot import Lang
from llm.pinecone_llm import PinecoinOperations




bot = APIRouter()


@bot.get("/chat")
async def get_response(query:str):
    # llm = ChatOpenAI(model="gpt-3.5-turbo", temperature=0, max_tokens=512, openai_api_key="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")
    # for chunk in llm.stream("Write me a song about sparkling water."):
    #  print(chunk, end="", flush=True)
    bot = Lang()
    data = bot.load_documents("pharmaease.pdf")
    chunks = bot.chunk_data(data = data , chunksize= 500)
    vector_store = bot.create_embeddings(chunks_data= chunks , key="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")
    answer = bot.qa(vector_store, query=query)
    return answer
