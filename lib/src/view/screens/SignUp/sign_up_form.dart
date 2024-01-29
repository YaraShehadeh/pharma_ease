import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/authentication_cubit.dart';
import 'package:pharmaease/src/controller/cubits/sign_up_cubit.dart';
import 'package:pharmaease/src/controller/states/authentication_state.dart';
import 'package:pharmaease/src/controller/states/sign_up_state.dart';
import 'package:pharmaease/src/view/widgets/sign_up_pop_up.dart';
import 'package:pharmaease/src/view/theme/colors.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<SignUpCubit>().clearForm();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    final authCubit = context.read<AuthenticationCubit>();
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
                      } else if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]')
                          .hasMatch(value)) {
                        return "Password must contain at least one special character";
                      }
                      return null;
                    },
                    controller: cubit.passwordController,
                    autofocus: false,
                    decoration: const InputDecoration(
                      hintText: "Your password",
                      focusColor: pharmaGreenColor,
                      prefixIcon: const Icon(Icons.lock_outline),
                      prefixIconColor: pharmaGreenColor,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: cubit.selectedAllergy,
            decoration: const InputDecoration(
                hintText: 'Your Allergy',
                prefixIcon: Icon(Icons.medication_outlined),
                prefixIconColor: pharmaGreenColor,
                focusColor: pharmaGreenColor),
            items: cubit.allergyOptions.map((String allergy) {
              return DropdownMenuItem<String>(
                value: allergy,
                child: Text(allergy,
                    style: const TextStyle(color: Colors.black54)),
              );
            }).toList(),
            onChanged: (String? value) {
              cubit.selectAllergy(value);
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
                fixedSize: const Size(500, 40),
              ),
              child:
                  const Text("Continue", style: TextStyle(color: Colors.white)),
              onPressed: () {
                onSubmit(
                  cubit.formKey,
                  authCubit,
                  cubit,
                  cubit.nameController,
                  cubit.emailController,
                  cubit.phoneNumberController,
                  cubit.passwordController,
                  cubit.allergiesController,
                );
                context.read<AuthenticationCubit>().stream.listen(
                  (state) {
                    if (state is SuccessfullyRegisteredState) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SignUpPopUp();
                        },
                      );
                    } else if (state is AlreadyRegisteredState) {
                      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                          content: Text('This email is already registered.')));
                    }
                  },
                );
              }),
        ],
      )),
    );
  }

  void onSubmit(
      GlobalKey<FormState> formKey,
      AuthenticationCubit authCubit,
      SignUpCubit cubit,
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController phoneNumberController,
      TextEditingController passwordController,
      TextEditingController allergiesController) {
    if (formKey.currentState!.validate()) {
      final allergiesText = allergiesController.text;
      final allergyList = allergiesText
          .split(',')
          .map((allergy) => allergy.trim())
          .where((allergy) => allergy.isNotEmpty)
          .toList();
      var user = User((b) => b
        ..name = nameController.value.text
        ..email = emailController.value.text
        ..password = passwordController.value.text
        ..allergies = ListBuilder<Allergie>(
          allergyList.map((allergy) => Allergie()),
        ));
      authCubit.signUp(user);
      TextInput.finishAutofillContext();
    }
  }
}
