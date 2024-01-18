import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/sign_in_cubit.dart';
import 'package:pharmaease/src/controller/states/sign_in_state.dart';
import 'package:pharmaease/src/view/theme/colors.dart';

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
          BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
            return TextFormField(
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.email],
                autofocus: false,
                decoration: const InputDecoration(
                  hintText: "Your email",
                  focusColor: pharmaGreenColor,
                  prefixIcon: Icon(Icons.email_outlined),
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
                          r"^[a-zA-Z0-9_.+-]+@[a-zA-Z.-]+\.[a-zA-Z]{2,4}$")
                      .hasMatch(value)) {
                    return "Please enter a valid email address";
                  }
                  else if (value.length < 8){
                    return "Please enter a valid email address";
                  }
                  return null;
                });
          }),
          const SizedBox(height: 20),
          TextFormField(
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            autofocus: false,
            decoration: InputDecoration(
              hintText: "Your password",
              focusColor: pharmaGreenColor,
              prefixIcon: const Icon(Icons.lock_outlined),
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
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              } else if (value.length < 6) {
                return "Password must be at least 6 characters long";
              } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
                return "Password must contain at least one uppercase letter";
              } else if (!RegExp(r'[a-z]').hasMatch(value)) {
                return "Password must contain at least one lowercase letter";
              } else if (!RegExp(r'[0-9]').hasMatch(value)) {
                return "Password must contain at least one digit";
              } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
                return "Password must contain at least one special character";
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20,
          ),
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
            child:
                const Text("Continue", style: TextStyle(color: Colors.white)),
          ),
        ]),
      ),
    );
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
