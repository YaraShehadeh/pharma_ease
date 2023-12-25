import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:pharmaease_api/pharmaease_api.dart';


class AllHoldingPharmaciesCubit extends Cubit <AllHoldingPharmaciesState> {
  AllHoldingPharmaciesCubit(num userLat,num userLon, String? barcode, BuiltList<String>? drugName ) : super(InitialAllHoldingPharmaciesState()) {
    getAllHoldingPharmacies( 41,41," ",BuiltList<String>(["panadol"]));
  }

  List <Pharmacy> pharmacies = [];
  int? pharmacyCount;

  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  Future<dynamic> getAllHoldingPharmacies(num userLat,num userLon, String?barcode, BuiltList<String>? drugName ) async {
    try {
      emit(LoadingAllHoldingPharmaciesState());
      List<Pharmacy>? result = (await _api.getPharmacyApi()
          .searchDrugsApiPharmacySearchHoldingPharmaciesPost(
          userLat: userLat, userLon: userLon,drugBarcode: barcode,requestBody: drugName)).data!.toList();
      print("!!!!!!!!!!!!!!");
      print(result);
      if( result == null){
        emit(ErrorAllHoldingPharmaciesState());
        return;
      }else{
        pharmacies=result;
        pharmacyCount= result.length;
        emit(LoadedAllHoldingPharmaciesState());
        return;
      }
    }
    on DioException catch(e){
      if(e.response!.statusCode==401){
        emit(ErrorAllHoldingPharmaciesState());
        print("Error: $e");
        throw Exception("Failed to load all holding pharmacies");
      }
    }
  }

}


abstract class AllHoldingPharmaciesState {}

class InitialAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}

class LoadingAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}

class LoadedAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}

class ErrorAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}

