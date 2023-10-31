# Folder Structure 

### Config : used for connection to external parties
### models: specify the pydantic models that will encapsulate the requests body and used in the 
### routes: Different routes for different application logic
### schema : make sure the data request adhere to a specific format
### services: this folder will contain the business logic to seperate 


# How to run the code 

### once you have cloned the repo , make sure to make python virtual envrinoment : python -m venv myenv
### install the required dependencies : pip install -r requirements.txt
### run the fastapi server: uvicorn main:app --reload
