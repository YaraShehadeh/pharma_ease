import 'dart:convert';
import 'package:pharmaease/src/model/pharmacy_details_model.dart';
import 'package:http/http.dart' as http;

class PharmacyDetailsController {
  PharmacyDetailsModel? pharmacyDetails;

  static const baseUrl = 'http://127.0.0.1:8000/api/pharmacy/all';

  Future<dynamic> getPharmacyDetails() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<PharmacyDetailsModel> pharmacies = jsonResponse
            .map((item) => PharmacyDetailsModel.fromJson(item))
            .toList();
        pharmacies.forEach((pharmacy) {
          print("Pharmacy name: ${pharmacy.pharmacyName}");
        });
        return pharmacies;
      } else {
        print("Failed to load pharmacies. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to load pharmacies");
      }
    }
    catch (e) {
      print("Error: $e");
      throw Exception("Failed to load pharmacies");
    }
  }
}