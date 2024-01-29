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
  final String token;

  const AuthenticatedState({required this.token});

  @override
  List<Object> get props => [];
}

class FailedAuthenticationState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class UnauthenticatedState extends AuthenticationState {
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

class AlreadyRegisteredState extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class SuccessfullyRegisteredState extends AuthenticationState {
  @override
  List<Object> get props => [];
}