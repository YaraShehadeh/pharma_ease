
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease_api/pharmaease_api.dart';
import 'package:built_collection/built_collection.dart';

class AlternativeDrugsCubit extends Cubit<AlternativeDrugsState> {
  AlternativeDrugsCubit() : super(InitialAlternativeDrugsState()) {}
  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  List<Drug>? drugs=[];

  Future<dynamic> getSearchedDrug(String? drugName,String? drugBarcode) async {
    try {
      emit(LoadingAlternativeDrugsState());
      List<Drug>? result = (await _api
          .getDrugApi().getDrugAlternativesApiDrugDrugDrugAlternativesGet(drugName: drugName,drugBarcode: drugBarcode))
          .data!.toList();

      print("ALTERNATIVES");
      print(result);
      if (result == null) {
        emit(ErrorAlternativeDrugsState());
      } else {
        drugs = result;
        emit(LoadedAlternativeDrugsState(drugs));
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        emit(ErrorAlternativeDrugsState());
        print("Errorrrrr: $e");
        throw Exception("Drug not found");
      }
      if(e.response!.statusCode==404){
        emit(IncorrectAlternativeSearchedDrugState());
        print("INCORRECT DRUG SEARCHED");
      }
      print("ERRORRR $e");
    }
  }
}

abstract class AlternativeDrugsState {}

class InitialAlternativeDrugsState extends AlternativeDrugsState {}

class LoadingAlternativeDrugsState extends AlternativeDrugsState {}

class LoadedAlternativeDrugsState extends AlternativeDrugsState {
  final List<Drug> ?drugs;
  LoadedAlternativeDrugsState(this.drugs);
}

class ErrorAlternativeDrugsState extends AlternativeDrugsState {}
class IncorrectAlternativeSearchedDrugState extends AlternativeDrugsState{}