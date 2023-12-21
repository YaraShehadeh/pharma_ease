import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/launcher_screen.dart';
import 'package:pharmaease/src/ui/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LauncherScreen(),
        '/second': (context) => const OnBoardingScreen(),
      },
    );
  }
}
