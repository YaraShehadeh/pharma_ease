import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease/src/controller/states/searched_drug_state.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class SearchedDrugCubit extends Cubit<SearchedDrugState> {
  SearchedDrugCubit() : super(InitialSearchedDrugState()) {}
  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  List<Drug>? drugs=[];
  // Drug ?drug;


  Future<dynamic> getSearchedDrug(String drugName) async {
    try {
      emit(LoadingSearchedDrugState());
      List<Drug>? result = (await _api
          .getDrugApi()
          .getDrugByNameOrBarcodeApiDrugDrugGet(drugName: drugName))
          .data!.toList();

      if (result == null) {
        emit(ErrorSearchedDrugState());
      } else {
        drugs = result;
        emit(LoadedSearchedDrugState());
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        emit(ErrorSearchedDrugState());
        print("Error: $e");
        throw Exception("Drug not found");
      }
    }
  }
}