import 'package:pharmaease_api/pharmaease_api.dart';

abstract class DrugDetailsState {}

class InitialDrugDetailsState extends DrugDetailsState {}

class LoadingDrugDetailsState extends DrugDetailsState {}

class LoadedDrugDetailsState extends DrugDetailsState {
  final Drug? drug;

  LoadedDrugDetailsState(this.drug);
}

class ErrorDrugDetailsState extends DrugDetailsState {}
