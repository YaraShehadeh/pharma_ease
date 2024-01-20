import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart' as location;
import 'package:pharmaease_api/pharmaease_api.dart';

class AllHoldingPharmaciesCubit extends Cubit<AllHoldingPharmaciesState> {
  AllHoldingPharmaciesCubit() : super(InitialAllHoldingPharmaciesState());

  final location.Location _locationController = location.Location();

  List<Pharmacy> pharmacies = [];

  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  Future<void> getBarcodeOrDrugName(String? barcode, BuiltList<String>? drugName) async {
    print("getBarcodeOrDrugName called with barcode: $barcode, drugName: $drugName ");
    try {
      emit(LoadingAllHoldingPharmaciesState());

      location.LocationData? currentUserLocation;
      bool _serviceEnabled;
      location.PermissionStatus _permissionGranted;

      _serviceEnabled = await _locationController.serviceEnabled();
      if (_serviceEnabled) {
        _serviceEnabled = await _locationController.requestService();
      } else {
        emit(ErrorAllHoldingPharmaciesState());
        return;
      }

      _permissionGranted = await _locationController.hasPermission();
      if (_permissionGranted == location.PermissionStatus.denied) {
        _permissionGranted = await _locationController.requestPermission();
        if (_permissionGranted != location.PermissionStatus.granted) {
          emit(ErrorAllHoldingPharmaciesState());
          return;
        }
      }

      currentUserLocation = await _locationController.getLocation();
      getAllHoldingPharmacies(currentUserLocation.latitude as double,
          currentUserLocation.longitude as double, barcode, drugName);
    } catch (e) {
      emit(ErrorAllHoldingPharmaciesState());
    }
  }

  Future<dynamic> getAllHoldingPharmacies(
    double userLat,
    double userLon,
    String? barcode,
    BuiltList<String>? drugName,
  ) async {
    try {
      List<Pharmacy>? result = (await _api
              .getPharmacyApi()
              .searchDrugsApiPharmacySearchHoldingPharmaciesPost(
                userLat: userLat,
                userLon: userLon,
                drugBarcode: barcode,
                requestBody: drugName,
              ))
          .data as List<Pharmacy>?;

      //Error State
      if (result == null) {
        emit(ErrorAllHoldingPharmaciesState());
        return;
      } else {
        pharmacies = result;
        emit(LoadedAllHoldingPharmaciesState(
            pharmacies: pharmacies)); //Successful retrieval state
        return;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        emit(ErrorAllHoldingPharmaciesState());
        print("Error: $e");
        throw Exception("Failed to load all holding pharmacies");
      }
      if (e.response!.statusCode == 404) {
        emit(NoHoldingPharmaciesFoundState()); //No pharmacies returned state
        print("Error: $e");
        throw Exception("Failed to load all holding pharmacies");
      }
    }
  }
}

abstract class AllHoldingPharmaciesState {}

class InitialAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}
class LoadingAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}
class LoadedAllHoldingPharmaciesState extends AllHoldingPharmaciesState {
  final List<Pharmacy> pharmacies;
  LoadedAllHoldingPharmaciesState({required this.pharmacies});
}
class ErrorAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}
class NoHoldingPharmaciesFoundState extends AllHoldingPharmaciesState {}
