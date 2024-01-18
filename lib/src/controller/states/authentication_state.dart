import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class InitialAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  const AuthenticatedState();

  @override
  List<Object> get props => [];
}

class FailedAuthenticationState extends AuthenticationState {
  final String error;
  const FailedAuthenticationState({required this.error});

  @override
  List<Object> get props => [];
}

class UnauthenticatedState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class UnknownAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class LoadingAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationTimedOutState extends AuthenticationState {
  @override
  List<Object> get props => [];
}