import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _password;
  String? _birthDate;
  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneNumberFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _birthDateFocus = FocusNode();

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
            TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              focusNode: _nameFocus,
              autofillHints: const [
                AutofillHints.name,
                AutofillHints.middleName,
                AutofillHints.familyName
              ],
              onFieldSubmitted: (_) {
                _nameFocus.unfocus();
              },
              autofocus: false,
              decoration: const InputDecoration(
                hintText: "Your name",
                focusColor: Color.fromRGBO(25, 154, 142, 100),
              ),
              onSaved: (_) => _name = _,
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              autofillHints: const [
                AutofillHints.username,
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
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              focusNode: _phoneNumberFocus,
              autofillHints: const [
                AutofillHints.telephoneNumber,
              ],
              onFieldSubmitted: (_) {
                _phoneNumberFocus.unfocus();
              },
              autofocus: false,
              decoration: const InputDecoration(
                hintText: "Your phone number",
                focusColor: Color.fromRGBO(25, 154, 142, 100),
              ),
              onSaved: (_) => _phoneNumber = _,
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
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
                  fixedSize: const Size(500, 40)),
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
