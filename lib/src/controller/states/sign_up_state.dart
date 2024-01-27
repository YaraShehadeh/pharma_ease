import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial({required this.hidePassword});
  final bool hidePassword;

  @override
  List<Object> get props => [hidePassword];
}

class SignUpFormUpdate extends SignUpState {
  const SignUpFormUpdate({required this.hidePassword});
  final bool hidePassword;

  @override
  List<Object> get props => [hidePassword];
}