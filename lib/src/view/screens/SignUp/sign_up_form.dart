import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/sign_up_cubit.dart';
import 'package:pharmaease/src/controller/states/sign_up_state.dart';
import 'package:pharmaease/src/view/theme/colors.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return Form(
      key: cubit.formKey,
      child: AutofillGroup(
        child: Column(
          children: [
            BlocBuilder<SignUpCubit, SignUpState>(
              builder: (context, state) {
                return Column(
                  children: [
                    TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [
                          AutofillHints.name,
                          AutofillHints.middleName,
                          AutofillHints.familyName
                        ],
                        autofocus: false,
                        decoration: const InputDecoration(
                          hintText: "Your name",
                          focusColor: pharmaGreenColor,
                          prefixIcon: Icon(Icons.person_outline),
                          prefixIconColor: pharmaGreenColor,
                        ),
                        controller: cubit.nameController,
                        onFieldSubmitted: (value) {
                          cubit.emailFocusNode.requestFocus();
                        },
                        validator: (value) {
                          if (value == null || value == "") {
                            return "Please enter your name";
                          } else if (!RegExp(r"^[a-zA-Z'-]{3,}( [a-zA-Z]+)?$")
                              .hasMatch(value)) {
                            return "Please enter a valid name with at least 3 letters";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      autofocus: false,
                      decoration: const InputDecoration(
                          hintText: "Your email",
                          focusColor: pharmaGreenColor,
                          prefixIcon: Icon(Icons.email_outlined),
                          prefixIconColor: pharmaGreenColor),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "Please enter your email";
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
                            .hasMatch(value)) {
                          return "Please enter a valid email address";
                        }
                        return null;
                      },
                      controller: cubit.emailController,
                      onFieldSubmitted: (value) {
                        cubit.phoneNumberFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [
                          AutofillHints.telephoneNumber,
                        ],
                        controller: cubit.phoneNumberController,
                        onFieldSubmitted: (value) {
                          cubit.passwordFocusNode.requestFocus();
                        },
                        autofocus: false,
                        decoration: const InputDecoration(
                          hintText: "Your phone number",
                          focusColor: Color.fromRGBO(25, 154, 142, 100),
                          prefixIcon: Icon(Icons.phone_outlined),
                          prefixIconColor: pharmaGreenColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your phone number";
                          } else if (!RegExp(r"^(07\d{8}|009627\d{8})$")
                              .hasMatch(value)) {
                            return "Please enter a valid phone number";
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.password],
                      onFieldSubmitted: (_) {
                        cubit.passwordFocusNode.unfocus();
                      },
                      controller: cubit.passwordController,
                      autofocus: false,
                      decoration: InputDecoration(
                        hintText: "Your password",
                        focusColor: pharmaGreenColor,
                        prefixIcon: const Icon(Icons.lock_outline),
                        prefixIconColor: pharmaGreenColor,
                        suffixIcon: IconButton(
                          icon: Icon((cubit.state is SignUpFormUpdate)
                              ? ((cubit.state as SignUpFormUpdate).hidePassword)
                                  ? Icons.visibility
                                  : Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            cubit.togglePasswordVisibility();
                          },
                        ),
                        suffixIconColor: pharmaGreenColor,
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 30),
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
          ],
        ),
      ),
    );
  }

  void onSubmit(
      GlobalKey<FormState> formKey,
      // AuthenticationCubit authCubit,
      SignUpCubit cubit,
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
