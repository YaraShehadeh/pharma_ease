import requests 

ENDPOINT =  "http://127.0.0.1:8000/api/pharmacy"

response = requests.get(ENDPOINT)

print(response.json())



def test_get_all_pharmacies():
    response = requests.get(ENDPOINT+"/all")
    print(response.json()[0])
    assert response.status_code == 200




def test_pharmacy_all_endpoints():

    payload = {
  "pharmacyName": "Orange Pharmacy",
  "pharmacyemail": "contact@Orange.jo",
  "pharmacyDescription": "A leading pharmacy in the heart of Amman, offering a wide range of medications and health products.",
  "pharmacyImage": "Orange_pharmacy.jpg",
  "pharmacyArea": "Jubaiha",
  "pharmacyDistance": "3 km from jubaiha circle",
  "pharmacyOpeningHours": "2024-01-03T15:36:18Z",
  "pharmacyClosingHours": "2024-01-03T15:36:18Z",
  "pharmacyPhoneNumber": "+962 6 123 4567",
  "location": {
    "longitude": "35.995160",
    "latitude": "30.111651"
  },
  "drugs": [
    {
      "drugName": "Panadol",
      "drugDescription": "Pain relief medication",
      "drugBarcode": "123456789012",
      "drugPerscription": "Take 500mg every 4-6 hours as needed, not to exceed 3000mg in 24 hours.",
      "drugInteractions": "Can interact with alcohol, causing liver damage. May also interact with other medications that affect the liver.",
      "drugImage": ["panadol.jpg"],
      "holdingPharmacies": ["Pharmacy A", "Pharmacy B"],
      "drugAlternatives": ["Tylenol", "Advil"],
      "Allergies": ["Acetaminophen allergy"]
    },
    {
      "drugName": "Vitamin C",
      "drugDescription": "Immune system booster",
      "drugBarcode": "9876543210987",
      "drugPerscription": "Take one tablet daily with food.",
      "drugInteractions": "Can interact with certain chemotherapy drugs.",
      "drugImage": ["vitamin_c.jpg"],
      "holdingPharmacies": ["Pharmacy C"],
      "drugAlternatives": ["Vitamin D", "Multivitamin"],
      "Allergies": ["Ascorbic Acid allergy"]
    }
  ],
  "pharmacists": [
    {
      "first_name": "Yousef",
      "last_name": "Al-ali",
      "username": "Yousef_ali",
      "password": "securepassword123"
    }
  ]
}


    response = requests.post(ENDPOINT + "/create",json=payload)
    assert response.status_code == 200
    name = response.json()
    print(name)
    assert get_pharmacy(name["id"]) == 200
    assert update_pharmacy(name["id"]) == 200
    assert delete_pharmacy(name["id"]) == 200




def get_pharmacy(pharmacy_id):
    response = requests.get(ENDPOINT+"/"+f"{pharmacy_id}")
    print(response.json())
    return response.status_code




def update_pharmacy(pharmacy_id):
    payload = {
  "pharmacyName": "Orange Pharmacy - updated",
  "pharmacyemail": "contact@Orange.jo",
  "pharmacyDescription": "A leading pharmacy in the heart of Amman, offering a wide range of medications and health products.",
  "pharmacyImage": "Orange_pharmacy.jpg",
  "pharmacyArea": "Jubaiha",
  "pharmacyDistance": "3 km from jubaiha circle",
  "pharmacyOpeningHours": "2024-01-03T15:36:18Z",
  "pharmacyClosingHours": "2024-01-03T15:36:18Z",
  "pharmacyPhoneNumber": "+962 6 123 4567",
  "location": {
    "longitude": "35.885160",
    "latitude": "30.001651"
  },
  "drugs": [
    {
      "drugName": "Panadol",
      "drugDescription": "Pain relief medication",
      "drugBarcode": "123456789012",
      "drugPerscription": "Take 500mg every 4-6 hours as needed, not to exceed 3000mg in 24 hours.",
      "drugInteractions": "Can interact with alcohol, causing liver damage. May also interact with other medications that affect the liver.",
      "drugImage": ["panadol.jpg"],
      "holdingPharmacies": ["Pharmacy A", "Pharmacy B"],
      "drugAlternatives": ["Tylenol", "Advil"],
      "Allergies": ["Acetaminophen allergy"]
    },
    {
      "drugName": "Vitamin C",
      "drugDescription": "Immune system booster",
      "drugBarcode": "9876543210987",
      "drugPerscription": "Take one tablet daily with food.",
      "drugInteractions": "Can interact with certain chemotherapy drugs.",
      "drugImage": ["vitamin_c.jpg"],
      "holdingPharmacies": ["Pharmacy C"],
      "drugAlternatives": ["Vitamin D", "Multivitamin"],
      "Allergies": ["Ascorbic Acid allergy"]
    }
  ],
  "pharmacists": [
    {
      "first_name": "Yousef",
      "last_name": "Al-ali",
      "username": "Yousef_ali",
      "password": "securepassword123"
    }
  ]
}
    

    response = requests.put(ENDPOINT+f"/{pharmacy_id}", json= payload)
    print(ENDPOINT+f"/{pharmacy_id}")
    return response.status_code




def delete_pharmacy(pharmacy_id):
    response = requests.delete(ENDPOINT + f"/{pharmacy_id}")
    return response.status_code
    


