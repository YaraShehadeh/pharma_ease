import 'package:pharmaease_api/pharmaease_api.dart';

abstract class AlternativeDrugsState {}

class InitialAlternativeDrugsState extends AlternativeDrugsState {}

class LoadingAlternativeDrugsState extends AlternativeDrugsState {}

class LoadedAlternativeDrugsState extends AlternativeDrugsState {
  final List<Drug> ?drugs;
  LoadedAlternativeDrugsState(this.drugs);
}

class ErrorAlternativeDrugsState extends AlternativeDrugsState {}
class IncorrectAlternativeSearchedDrugState extends AlternativeDrugsState{}