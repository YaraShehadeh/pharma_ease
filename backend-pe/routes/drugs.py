from fastapi import APIRouter, HTTPException, status
from config.database import drugs_collection, collection_name
from schema.drugs import drugEntity, drugsEntity, filter_wrong_medicines
from models.mlocation import Location
from typing import List, Optional, Union
from models.mdrugs import Drug
from dao.drug_dao import DrugDAO
import re
import requests

drug = APIRouter()



@drug.post("/create_drug")
async def create_drug(drug: Drug):
    drug_dict = drug.dict()
    drug_id = await drugs_collection.insert_one(drug_dict)
    return {"id":str(drug_id)}



# @drug.get("/drugname/{drug_name}")
# async def get_drug_by_name(drug_name: Union[str,None], drug_barcode: Union[str,None]):
#     regex_pattern = f"^{drug_name}.*"   
#     # drug_cursor = drugs_collection.find({"drugName": {"$regex": regex_pattern, "$options": "i"}}) 
#     drug_cursor = collection_name.find({"drugs.drugName": {"$regex": regex_pattern, "$options": "i"}}) 
#     if drug_cursor:
#         try: 
#             drugs = await drug_cursor.to_list(length=None)
#             if drugs:
#                 # entity2 = [drug["drugs"] for drug in entity ]
#                 pre_processed_drugs = [drugsEntity(drug["drugs"]) for drug in drugs]  
#                 post_processed_drugs = filter_wrong_medicines(drug_name,pre_processed_drugs)
#                 return post_processed_drugs
#             else:
#                 raise HTTPException(status_code=404, detail="Drug not found")
#         except Exception as e:
#             print(e)
#     elif drug_barcode:
#         query = {}
#         query["drugs.drugBarcode"] = re.compile(r'^{}$'.format(drug_barcode), re.IGNORECASE)






@drug.get("/drug")
async def get_drug_by_name_or_barcode(drug_name: Optional[str] = None, drug_barcode: Optional[str] = None) -> list[Drug]:
    if drug_name:
        drugs = await DrugDAO.get_drugs(drug_name= drug_name)
        if drugs:  
            try:
                # Check if any drugs were found
                
                if not drugs:
                    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Drug not found with the given name")
                
                # Process the drugs if found
                pre_processed_drugs = [drugsEntity(drug["drugs"]) for drug in drugs]
                post_processed_drugs = filter_wrong_medicines(drug_name, pre_processed_drugs,"drugName")
                if not post_processed_drugs:
                    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="No drugs found after processing")
                return post_processed_drugs

            except Exception as e:
                print(e)
                raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Server Error")
        else: 
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Drug not found with the given name")

    elif drug_barcode:
        query = {"drugs.drugBarcode": re.compile(r'^{}$'.format(drug_barcode), re.IGNORECASE)}
        drug_cursor = collection_name.find(query)
        try:
            drugs = await drug_cursor.to_list(length=None)
            # Check if any drugs were found
            if not drugs:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Drug not found with the given barcode")
            
            # Process the drugs if found
            pre_processed_drugs = [drugsEntity(drug["drugs"]) for drug in drugs]
            post_processed_drugs = filter_wrong_medicines(drug_barcode, pre_processed_drugs, "drugBarcode")
            return post_processed_drugs

        except Exception as e:
            print(e)
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Server Error")

    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Either drug name or drug barcode must be provided")


@drug.get("/drug/drug_information")
async def get_drug_info(drug_name: str) -> Drug:
    # Validate drug_name format
    if not re.match("^[A-Za-z ]+$", drug_name):
        raise HTTPException(status_code=400, detail="Invalid drug name format")

    # Existing logic for drug information retrieval
    regex_pattern = f"^{drug_name}$"
    drug_cursor = collection_name.find({"drugs.drugName": {"$regex": regex_pattern, "$options": "i"}})
    try:
        drugs = await drug_cursor.to_list(length=None)
        print(drugs)
        if drugs:
            pre_processed_drugs = [drugsEntity(drug["drugs"]) for drug in drugs]
            post_processed_drugs = filter_wrong_medicines(drug_name, pre_processed_drugs, "drugName")
            return post_processed_drugs[0]
        else:
            raise HTTPException(status_code=404, detail="Drug not found with the given name")
    except Exception as e:
        print(e)
        raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Server Error")
    

# @drug.get("/drug/drug_info")
# async def get_drug_info(drug_name: str):
#     pass


@drug.get("/drug/drug_alternatives")
async def get_drug_alternatives(drug_name: Optional[str] = None, drug_barcode: Optional[str] = None):
    if drug_name:
        drugs = await DrugDAO.get_exact_drug(drug_name= drug_name)
        if drugs:  
            try:
                # Check if any drugs were found
                if not drugs:
                    raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Drug not found with the given name")
                
                # Process the drugs if found
                pre_processed_drugs = [drugsEntity(drug["drugs"]) for drug in drugs]
                post_processed_drugs = filter_wrong_medicines(drug_name, pre_processed_drugs,"drugName")
                if not post_processed_drugs:
                    return []
                

                alternative_drug_details = []
                print("one")
                                
                # here are the steps to return the drug alternatives
                if post_processed_drugs[0].drugAlternatives:
                    # print("two")
                    # alternatives_list = post_processed_drugs[0].drugAlternatives
                    # print("Alternatives:", alternatives_list)
                

                    # Example: Fetch details for each alternative
                    # for med in alternatives_list:
                    for med in post_processed_drugs[0].drugAlternatives:
                        # alternative_drug_details = await get_drug_by_name_or_barcode(med)
                        # print(f"Details for {med}:", alternative_drug_details)
                        # if alternative_drug_details:
                        #     return alternative_drug_details
                        details = await get_drug_by_name_or_barcode(med)
                        if details:
                            alternative_drug_details.append(details)
                        
                if not alternative_drug_details:
                    return []
                
                print(alternative_drug_details)
                
                return alternative_drug_details[0]
            
                # else:
                #     print("No alternatives found")
                #     raise HTTPException(status_code=404, detail="Alternative Drug not found with the given name")


            except Exception as e:
                print(e)
                raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Server Error")
        else: 
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Drug not found with the given name")

    elif drug_barcode:
        query = {"drugs.drugBarcode": re.compile(r'^{}$'.format(drug_barcode), re.IGNORECASE)}
        drug_cursor = collection_name.find(query)
        try:
            drugs = await drug_cursor.to_list(length=None)
            # Check if any drugs were found
            if not drugs:
                raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Drug not found with the given barcode")
            
            # Process the drugs if found
            pre_processed_drugs = [drugsEntity(drug["drugs"]) for drug in drugs]
            post_processed_drugs = filter_wrong_medicines(drug_barcode, pre_processed_drugs, "drugBarcode")
            return post_processed_drugs

        except Exception as e:
            print(e)
            raise HTTPException(status_code=status.HTTP_500_INTERNAL_SERVER_ERROR, detail="Server Error")

    else:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Either drug name or drug barcode must be provided")



        