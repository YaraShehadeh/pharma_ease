import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/launcher_screen.dart';
import 'dart:async';
import 'package:pharmaease/src/ui/screens/onboarding_screen.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LauncherScreen(),
        '/second': (context) => OnBoardingScreen(),
      },
    );
  }
}
