from fastapi.testclient import TestClient
# from routes.pharmacy import pharmacy
from  main import app

client = TestClient(app)

def test_get_all_pharmacies():
    response = client.get("/api/pharmacy/all")
    assert response.status_code == 200
    assert type(response.json()) == list

def test_search_drugs_without_params():
    response = client.post("/api/pharmacy/searchHoldingPharmacies")
    assert response.status_code == 400
    assert response.json() == {"detail": "Either drug names or barcode must be provided"}

def test_search_nearest_pharmacies():
    response = client.get("/api/pharmacy/searchNearestPharmacies?user_lat=40.7128&user_lon=-74.0060")
    assert response.status_code == 200
    assert type(response.json()) == list