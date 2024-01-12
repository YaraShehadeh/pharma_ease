import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/sign_in_form.dart';

//ADD AUTHENTICATION CUBIT HEREEE
class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
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
            const Text("Welcome Back!",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                )),
            const SizedBox(height: 20),
            SignInForm(),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: Color.fromRGBO(25, 154, 142, 100),
                      fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
