import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String? _email;
  String? _password;
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

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
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              autofillHints: const [
                AutofillHints.username,
                AutofillHints.telephoneNumber,
                AutofillHints.email
              ],
              onFieldSubmitted: (_) {
                _emailFocus.unfocus();
              },
              autofocus: false,
              decoration: const InputDecoration(
                hintText: "Your email",
                focusColor: Color.fromRGBO(25, 154, 142, 100),
              ),
              onSaved: (_) => _email = _,
            ),
            const SizedBox(height: 20),
            TextFormField(
              textInputAction: TextInputAction.done,
              focusNode: _passwordFocus,
              autofillHints: const [AutofillHints.password],
              onFieldSubmitted: (_) {
                _passwordFocus.unfocus();
              },
              autofocus: false,
              decoration: const InputDecoration(hintText: "Your password"),
              onSaved: (_) => _password = _,
            ),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                      color: Color.fromRGBO(25, 154, 142, 100),
                      fontWeight: FontWeight.bold),
                )),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
                  fixedSize: const Size(500, 40)),
              child: const Text("Continue"),
            ),
            const SizedBox(height: 15),
            const Row(
              children: [
                Expanded(child: Divider(thickness: 0.6)),
                SizedBox(width: 30),
                Text(
                  "Or",
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(width: 30),
                Expanded(child: Divider(thickness: 0.6)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
