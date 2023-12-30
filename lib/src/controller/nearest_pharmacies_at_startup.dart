import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart' as location;
import 'package:pharmaease_api/pharmaease_api.dart';


class NearestPharmaciesAtStartupCubit
    extends Cubit<NearestPharmaciesAtStartupState> {
  NearestPharmaciesAtStartupCubit()
      : super(InitialNearestPharmaciesAtStartupState());

  final location.Location _locationController = location.Location();

  List<Pharmacy> pharmacies = [];
  int? pharmacyCount;

  final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();

  Future<void> getUserLocationAutomaticallyAtStartup() async {
    location.LocationData? currentUserLocation;
    try {
      bool _serviceEnabled;
      location.PermissionStatus _permissionGranted;
      _serviceEnabled = await _locationController.serviceEnabled();
      if (_serviceEnabled) {
        _serviceEnabled = await _locationController.requestService();
      } else {
        return;
      }
      _permissionGranted = await _locationController.hasPermission();
      if (_permissionGranted == location.PermissionStatus.denied) {
        _permissionGranted = await _locationController.requestPermission();
        if (_permissionGranted != location.PermissionStatus.granted) {
          return;
        }
      }
      currentUserLocation = await _locationController.getLocation();
      getNearestPharmaciesAtStartup(currentUserLocation.latitude as num,
          currentUserLocation.longitude as num);
    } catch (e) {
      emit(ErrorNearestPharmaciesAtStartupState());
      print("Error fetching Location: $e");
    }
  }

  Future<dynamic> getNearestPharmaciesAtStartup(
      num userLat, num userLon) async {
    try {
      emit(LoadingNearestPharmaciesAtStartupState());
      List<Pharmacy>? result = (await _api
              .getPharmacyApi()
              .searchNearestPharmaciesApiPharmacySearchNearestPharmaciesGet(
                  userLat: userLat, userLon: userLon))
          .data
          ?.toList();

      if (result == null) {
        emit(ErrorNearestPharmaciesAtStartupState());
        return;
      } else {
        pharmacies = result;
        pharmacyCount = result.length;

        emit(LoadedNearestPharmaciesAtStartupState(pharmacies: pharmacies));
        return;
      }
    } on DioException catch (e) {
      if (e.response!.statusCode == 401) {
        emit(ErrorNearestPharmaciesAtStartupState());
        print("Error: $e");
        throw Exception("Failed to load all holding pharmacies");
      }
    }
  }
}

abstract class NearestPharmaciesAtStartupState {}

class InitialNearestPharmaciesAtStartupState
    extends NearestPharmaciesAtStartupState {}

class LoadingNearestPharmaciesAtStartupState
    extends NearestPharmaciesAtStartupState {}

class LoadedNearestPharmaciesAtStartupState
    extends NearestPharmaciesAtStartupState {
  final List<Pharmacy> pharmacies;

  LoadedNearestPharmaciesAtStartupState({required this.pharmacies});
}

class ErrorNearestPharmaciesAtStartupState
    extends NearestPharmaciesAtStartupState {}