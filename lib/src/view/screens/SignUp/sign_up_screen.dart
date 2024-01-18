import 'package:flutter/material.dart';
import 'package:pharmaease/src/view/screens/SignIn/sign_in_screen.dart';
import 'package:pharmaease/src/view/screens/SignUp/sign_up_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext build) {
    return Material(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
            top: 70, bottom: 20, start: 20, end: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Image(
                image: AssetImage('assets/images/pharmaease_logo.png'),
                height: 80,
                width: 80),
            const SizedBox(height: 20),
            const Text("Create Account!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
            const SizedBox(height: 20),
            SignUpForm(),
            const SizedBox(height: 20),
            Row(children: [
              const Text("Already have an account? "),
              GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          const SignInScreen()), // Replace 'SearchMedicineScreen' with the actual class for your search medicine screen
                    );
                  },
                  child: const Text(
                    "Sign In",
                    style: TextStyle(
                        color: Color.fromRGBO(25, 154, 142, 100),
                        fontWeight: FontWeight.bold),
                  )),
            ]),
          ],
        ),
      ),
    );
  }
}
