import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease/src/controller/states/drug_details_state.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class DrugDetailsCubit extends Cubit<DrugDetailsState> {
  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  DrugDetailsCubit() : super(InitialDrugDetailsState()) {}
  Drug? drug;

  Future<dynamic> getDrugDetails(String drugName) async {
    try {
      emit(LoadingDrugDetailsState());
     Drug? result = (await _api
              .getDrugApi().getDrugInfoApiDrugDrugDrugInformationGet(drugName: drugName))
          .data;
      if (result == null) {
        emit(ErrorDrugDetailsState());
      } else {
        drug = result;

        emit(LoadedDrugDetailsState(drug));
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