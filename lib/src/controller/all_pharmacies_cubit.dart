import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:pharmaease/src/model/pharmacy_details_model.dart';
import 'package:http/http.dart' as http;

class AllPharmaciesCubit extends Cubit<AllPharmaciesState> {
  AllPharmaciesCubit() : super(InitialAllPharmaciesState());

  static const baseUrl = 'http://10.0.2.2:8000/api/pharmacy/all';

  Future<dynamic> getPharmacyDetails() async {
    emit(LoadingAllPharmaciesState());
    try {
      final response = await http.get(Uri.parse('$baseUrl'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        final List<PharmacyDetailsModel> pharmacies = jsonResponse
            .map((item) => PharmacyDetailsModel.fromJson(item))
            .toList();
        pharmacies.forEach((pharmacy) {
          print("Pharmacy name: ${pharmacy.name}");
        });
        emit(LoadedAllPharmaciesState());
        return pharmacies;
      } else {
        print("Failed to load pharmacies. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to load pharmacies");
      }
    } catch (e) {
      emit(ErrorAllPharmaciesState());
      print("Error: $e");
      throw Exception("Failed to load pharmacies");
    }
  }
}

abstract class AllPharmaciesState {}

class InitialAllPharmaciesState extends AllPharmaciesState {}

class LoadingAllPharmaciesState extends AllPharmaciesState {}

class LoadedAllPharmaciesState extends AllPharmaciesState {}

class ErrorAllPharmaciesState extends AllPharmaciesState {}
