import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/sign_in_cubit.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    // final authCubit = context.read<AuthenticationCubit>();
    return Form(
      key: cubit.formKey,
      child: AutofillGroup(
        child: Column(children: [
          BlocBuilder<SignInCubit, SignInState>(
            builder: (context, state) {
              return TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  autofocus: false,
                  decoration: const InputDecoration(
                    hintText: "Your email",
                    focusColor: pharmaGreenColor,
                    prefixIcon: Icon(Icons.person_outline),
                    prefixIconColor: pharmaGreenColor,
                  ),
                  controller: cubit.emailController,
                  onFieldSubmitted: (value) {
                    cubit.passwordFocuseNode.requestFocus();
                  },
                  validator: (value) {
                    if (value == null || value == "") {
                      return "Please enter your email";
                    } else if (!RegExp(
                            r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                        .hasMatch(value)) {
                      return "Please enter a valid email address";
                    }
                    return null;
                  });
            }
          ),
          const SizedBox(height: 20),
          TextFormField(
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Your password",
              focusColor: pharmaGreenColor,
              prefixIcon: const Icon(Icons.lock),
              prefixIconColor: pharmaGreenColor,
              suffixIcon: IconButton(
                icon: Icon((cubit.state is SignInFormUpdate)
                    ? ((cubit.state as SignInFormUpdate).hidePassword)
                        ? Icons.visibility
                        : Icons.visibility_off
                    : Icons.visibility),
                onPressed: () {
                  cubit.togglePasswordVisibility();
                },
              ),
              suffixIconColor: pharmaGreenColor,
            ),
            controller: cubit.passwordController,
            obscureText: (cubit.state is SignInFormUpdate)
                ? (cubit.state as SignInFormUpdate).hidePassword
                : true,
            validator: (value) {
              if (value == null || value == "") {
                return "Please enter your password";
              } else if (value.length < 6) {
                return "Password must be at least 6 characters long";
              } else if (!containsSpecialChar(value)) {
                return "Password must contain at least one special character";
              } else if (!containsLowerCase(value)) {
                return "Password must contain at least one lowercase letter";
              } else if (!containsUpperCase(value)) {
                return "Password must contain at least one uppercase letter";
              }
              return null;
            },
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
            onPressed: () {
              onSubmit(
                cubit.formKey,
                // authCubit,
                cubit,
                cubit.emailController,
                cubit.passwordController,
                false,
              );
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
                fixedSize: const Size(500, 40)),
            child: const Text("Continue"),
          ),
        ]),
      ),
    );
  }

  bool containsSpecialChar(String value) {
    RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    return specialCharRegex.hasMatch(value);
  }

  bool containsLowerCase(String value) {
    return value.contains( RegExp(r'[a-z]') );
  }

  bool containsUpperCase(String value) {
    return value.contains( RegExp(r'[A-Z]') );
  }

  void onSubmit(
      GlobalKey<FormState> formKey,
      // AuthenticationCubit authCubit,
      SignInCubit cubit,
      TextEditingController employeeNumController,
      TextEditingController passwordController,
      bool accept) {
    if (formKey.currentState!.validate()) {
      // authCubit.requestLogin(
      //   int.parse(employeeNumController.value.text),
      //   passwordController.value.text,
      //   accept,
      // );
      // TextInput.finishAutofillContext();
    }
  }
}
