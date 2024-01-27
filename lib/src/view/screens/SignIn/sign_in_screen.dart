import 'package:flutter/material.dart';
import 'package:pharmaease/src/view/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/view/screens/SignIn/sign_in_form.dart';
import 'package:pharmaease/src/view/screens/SignUp/sign_up_screen.dart';
import 'package:pharmaease/src/view/theme/colors.dart';

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: pharmaGreenColor),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
            },
            iconSize: 30,
          ),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
              top: 10, bottom: 20, start: 20, end: 20),
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
              const SignInForm(),
              const SizedBox(height: 20),
              Row(children: [
                const Text("Don't have an account? "),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const SignUpScreen()), // Replace 'SearchMedicineScreen' with the actual class for your search medicine screen
                            );
                    },
                    child: const Text(
                      "Create one!",
                      style: TextStyle(
                          color: Color.fromRGBO(25, 154, 142, 100),
                          fontWeight: FontWeight.bold),
                    )),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
