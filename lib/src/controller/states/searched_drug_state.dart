import 'package:pharmaease_api/pharmaease_api.dart';

abstract class SearchedDrugState {}

class InitialSearchedDrugState extends SearchedDrugState {}

class LoadingSearchedDrugState extends SearchedDrugState {}

class LoadedSearchedDrugState extends SearchedDrugState {
  final List<Drug> ?drugs;
  LoadedSearchedDrugState(this.drugs);
}

class ErrorSearchedDrugState extends SearchedDrugState {}

class IncorrectSearchedDrugState extends SearchedDrugState {}