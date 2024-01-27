import 'package:pharmaease_api/pharmaease_api.dart';

abstract class PharmacyDetailsState {}

class InitialPharmacyDetailsState extends PharmacyDetailsState {}

class LoadingPharmacyDetailsState extends PharmacyDetailsState {}

class LoadedPharmacyDetailsState extends PharmacyDetailsState {
  final Pharmacy? pharmacy;
  LoadedPharmacyDetailsState(this.pharmacy);
}

class ErrorPharmacyDetailsState extends PharmacyDetailsState {}
