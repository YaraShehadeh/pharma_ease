import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsetsDirectional.only(
              top: 70, bottom: 20, start: 20, end: 20),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Image(
                  image: AssetImage('assets/images/pharmaease_logo.png'),
                  height: 80,
                  width: 80),
              const SizedBox(height: 20),
              const Text("Forgot Password",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
              Form(
                  child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Your email",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color.fromRGBO(25, 154, 142, 100)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(25, 154, 142, 100),
                        fixedSize: const Size(500, 40)),
                    child: const Text(
                      "Send Code",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
