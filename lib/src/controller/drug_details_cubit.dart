import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class DrugDetailsCubit extends Cubit<DrugDetailsState> {
  Drug drug = Drug();
  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  DrugDetailsCubit(String drugName) : super(InitialDrugDetailsState()) {
    getMedicineCard(drugName);
  }

  Future<void> getMedicineCard(String drugName) async {
    try {
      emit(LoadingDrugDetailsState());
      Drug? result = (await _api
          .getDrugApi()
          .getDrugByNameApiDrugDrugnameDrugNameGet(drugName: drugName))
          .data;
      if (result == null) {
        emit(ErrorDrugDetailsState());
      } else {
        drug = result;
        emit(LoadedDrugDetailsState());
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        emit(ErrorDrugDetailsState());
        print("Error: $e");
        throw Exception("Drug not found");
      }
    }
  }
}

abstract class DrugDetailsState {}

class InitialDrugDetailsState extends DrugDetailsState {}

class LoadingDrugDetailsState extends DrugDetailsState {}

class LoadedDrugDetailsState extends DrugDetailsState {}

class ErrorDrugDetailsState extends DrugDetailsState {}
