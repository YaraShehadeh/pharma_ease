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

  List<String> allergiesList = <String>[
    "None",
    "Pencillin",
    "Sulfa Drugs",
    "Acetaminophen"
  ];
  String selectedAllergy = "None";

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
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(25, 154, 142, 100)),
                ),
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
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(25, 154, 142, 100)),
                ),
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
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(25, 154, 142, 100)),
                ),
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
              decoration: const InputDecoration(
                hintText: "Your password",
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromRGBO(25, 154, 142, 100)),
                ),
              ),
              onSaved: (_) => _password = _,
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedAllergy,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedAllergy = newValue!;
                  });
                },
                items:
                    allergiesList.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(color: Colors.black54),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
                  fixedSize: const Size(500, 40)),
              child: const Text(
                "Sign Up",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
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
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                  icon: const Image(
                      image: AssetImage('assets/images/google_logo.png'),
                      width: 20),
                  onPressed: () {},
                  label: const Text(
                    "Sign Up With Google",
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  const SignUpScreen();
                },
                child: const Text.rich(
                  TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: TextStyle(
                            color: Color.fromRGBO(25, 154, 142, 100),
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
