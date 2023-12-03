import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
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
              const Text("Please check your email",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
              const SizedBox(height: 20),
              const Text(
                "Enter the verification sent at lamissw@hotmail.com",
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              OtpTextField(
                focusedBorderColor: const Color.fromRGBO(25, 154, 142, 100),
                mainAxisAlignment: MainAxisAlignment.center,
                numberOfFields: 4,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                fieldWidth: 50,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                onSubmit: (code) => print("OTP is $code"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
                    fixedSize: const Size(500, 40)),
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
