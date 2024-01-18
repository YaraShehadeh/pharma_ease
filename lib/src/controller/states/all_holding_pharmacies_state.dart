import 'package:pharmaease_api/pharmaease_api.dart';

abstract class AllHoldingPharmaciesState {}

class InitialAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}

class LoadingAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}

class LoadedAllHoldingPharmaciesState extends AllHoldingPharmaciesState {
  final List<Pharmacy> pharmacies;
  LoadedAllHoldingPharmaciesState({required this.pharmacies});
}

class ErrorAllHoldingPharmaciesState extends AllHoldingPharmaciesState {}

class NoHoldingPharmaciesFoundState extends AllHoldingPharmaciesState{}