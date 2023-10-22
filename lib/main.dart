import 'package:flutter/material.dart';
import 'dart:async';
import 'package:pharmaease/src/ui/screens/onboarding_screen.dart';
import 'package:pharmaease/src/ui/screens/map_page.dart';
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

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
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
                    color: const Color(0xFF199A8E),
                    fontSize: 30),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: const Center(
        child: Text(
          'This is the second screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
