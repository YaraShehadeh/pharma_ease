import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/states/sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpInitial(hidePassword: true));

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  void clearForm(){
    nameController.clear();
    emailController.clear();
    phoneNumberController.clear();
    passwordController.clear();
  }

  void togglePasswordVisibility() {
    if (state is SignUpFormUpdate) {
      bool hidePassword = !(state as SignUpFormUpdate).hidePassword;
      emit(SignUpFormUpdate(hidePassword: hidePassword));
    } else {
      emit(const SignUpFormUpdate(hidePassword: false));
    }
  }

}