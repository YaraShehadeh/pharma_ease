import 'package:bloc/bloc.dart';
import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease_api/pharmaease_api.dart';


class PharmacyDetailsCubit extends Cubit<PharmacyDetailsState> {
  PharmacyDetailsCubit() : super(InitialPharmacyDetailsState());

  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  Pharmacy? pharmacy;

  Future<dynamic> getPharmacyInformation(String pharmacyName) async {
    try {
      emit(LoadingPharmacyDetailsState());
      Pharmacy? result = (await _api.getPharmacyApi()
          .getPharmacyByNameApiPharmacyNamePharmacyNameGet(
          pharmacyName: JsonObject(pharmacyName))).data;

      print("!!!!!!!!!!!!!!");
      print(result);
      if (result == null) {
        emit(ErrorPharmacyDetailsState());
        return;
      } else {
        pharmacy = result;
        emit(LoadedPharmacyDetailsState(pharmacy as Pharmacy?));
        return;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        emit(ErrorPharmacyDetailsState());
        print("Error: $e");
        throw Exception("Failed to load pharmacy details");
      }
    }
  }
}

abstract class PharmacyDetailsState {}

class InitialPharmacyDetailsState extends PharmacyDetailsState {}

class LoadingPharmacyDetailsState extends PharmacyDetailsState {}

class LoadedPharmacyDetailsState extends PharmacyDetailsState {
  final Pharmacy? pharmacy;
  LoadedPharmacyDetailsState(this.pharmacy);
}

class ErrorPharmacyDetailsState extends PharmacyDetailsState {}
