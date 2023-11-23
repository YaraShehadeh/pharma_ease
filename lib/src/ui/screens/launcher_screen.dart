
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LauncherScreen extends StatefulWidget {
  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/second');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/pharmaease_logo.png",
                width: 250,
                height: 250,
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                'PharmaEase',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF199A8E),
                  fontFamily: GoogleFonts.kaushanScript().fontFamily,
                  fontSize: 60,
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ));
  }
}
