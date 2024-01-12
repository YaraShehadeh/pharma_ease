import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInInitial(hidePassword: true));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode passwordFocuseNode = FocusNode();

  void togglePasswordVisibility() {
    if (state is SignInFormUpdate) {
      bool hidePassword = !(state as SignInFormUpdate).hidePassword;
      emit(SignInFormUpdate(hidePassword: hidePassword));
    } else {
      emit(const SignInFormUpdate(hidePassword: false));
    }
  }
}

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