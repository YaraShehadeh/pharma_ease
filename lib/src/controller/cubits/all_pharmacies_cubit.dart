import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease/src/controller/states/all_pharmacies_state.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class AllPharmaciesCubit extends Cubit<AllPharmaciesState> {
  AllPharmaciesCubit() : super(InitialAllPharmaciesState()) {
    getAllPharmacies();
  }
  List<Pharmacy> pharmacies = [];
  int? pharmacyCount;

  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  Future<dynamic> getAllPharmacies() async {
    try {
      emit(LoadingAllPharmaciesState());
      List<Pharmacy>? result =
      (await _api.getPharmacyApi().getAllPharmaciesApiPharmacyAllGet())
          .data!
          .toList();
      if (result == null) {
        emit(ErrorAllPharmaciesState());
        return;
      } else {
        pharmacies = result;
        pharmacyCount = result.length;
        emit(LoadedAllPharmaciesState());
        return;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        emit(ErrorAllPharmaciesState());
        return;
      }
    } catch (e) {
      emit(ErrorAllPharmaciesState());
      print("Error: $e");
      throw Exception("Failed to load pharmacies");
    }
  }
}