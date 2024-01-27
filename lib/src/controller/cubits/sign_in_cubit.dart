import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/states/sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInInitial(hidePassword: true));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode passwordFocuseNode = FocusNode();

  void clearForm(){
    emailController.clear();
    passwordController.clear();
  }

  void togglePasswordVisibility() {
    if (state is SignInFormUpdate) {
      bool hidePassword = !(state as SignInFormUpdate).hidePassword;
      emit(SignInFormUpdate(hidePassword: hidePassword));
    } else {
      emit(const SignInFormUpdate(hidePassword: false));
    }
  }
}