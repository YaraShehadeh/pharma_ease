import 'package:pharmaease_api/pharmaease_api.dart';

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
