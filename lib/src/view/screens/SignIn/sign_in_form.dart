import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/authentication_cubit.dart';
import 'package:pharmaease/src/controller/cubits/sign_in_cubit.dart';
import 'package:pharmaease/src/controller/states/authentication_state.dart';
import 'package:pharmaease/src/controller/states/sign_in_state.dart';
import 'package:pharmaease/src/view/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/view/theme/colors.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  void initState(){
    super.initState();
    context.read<SignInCubit>().clearForm();
  }
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignInCubit>();
    final authCubit = context.read<AuthenticationCubit>();
    return Form(
      key: cubit.formKey,
      child: AutofillGroup(
        child: Column(children: [
          BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
            return TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your email";
                }
                return null;
              },
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
            );
          }),
          const SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
            obscureText: !(cubit.state is SignInFormUpdate)|| !(cubit.state as SignInFormUpdate).hidePassword,
            focusNode: cubit.passwordFocuseNode,
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
                  setState(() {});
                },
              ),
              suffixIconColor: pharmaGreenColor,
            ),
            controller: cubit.passwordController,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              onSubmit(cubit.formKey, authCubit, cubit, cubit.emailController,
                  cubit.passwordController);
              context.read<AuthenticationCubit>().stream.listen((state) {
                if (state is AuthenticatedState) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const MapPage()), // Replace 'SearchMedicineScreen' with the actual class for your search medicine screen
                  );
                } else if (state is FailedAuthenticationState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Incorrect email or password')));
                }
              });
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
      AuthenticationCubit authCubit,
      SignInCubit cubit,
      TextEditingController emailController,
      TextEditingController passwordController) {
    if (formKey.currentState!.validate()) {
      authCubit.signIn(
        emailController.value.text,
        passwordController.value.text,
      );
      TextInput.finishAutofillContext();
    }
  }
}
