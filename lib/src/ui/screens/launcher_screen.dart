import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
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
              const SizedBox(
                height: 16,
              ),
              Text(
                'PharmaEase',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: pharmaGreenColor,
                  fontFamily: GoogleFonts.kaushanScript().fontFamily,
                  fontSize: 60,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }
}
