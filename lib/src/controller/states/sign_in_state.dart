import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {
  const SignInInitial({required this.hidePassword});
  final bool hidePassword;

  @override
  List<Object> get props => [hidePassword];
}

class SignInFormUpdate extends SignInState {
  const SignInFormUpdate({required this.hidePassword});
  final bool hidePassword;

  @override
  List<Object> get props => [hidePassword];
}