import 'dart:convert';
import 'package:pharmaease/src/model/pharmacy_details_model.dart';
import 'package:http/http.dart' as http;

class PharmacyDetailsController {
  static const baseUrl = '/api/pharmacy';

  Future<List<PharmacyDetailsModel>> getAllPharmacyDetails() async {
    final response = await http.get(Uri.parse('$baseUrl/all'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = json.decode(response.body);
      final List<PharmacyDetailsModel> pharmacies =  jsonResponse
          .map((item) => PharmacyDetailsModel.fromJson(item))
          .toList();
      pharmacies.forEach((pharmacy) {
        print("Pharmacy name: ${pharmacy.pharmacyName}");
      });
      return pharmacies;
    } else {
      throw Exception("Failed to load pharmacies");
    }
  }
}
