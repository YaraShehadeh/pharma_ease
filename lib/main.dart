import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/forgot_password_screen.dart';
import 'dart:async';
import 'package:pharmaease/src/ui/screens/onboarding_screen.dart';
import 'package:pharmaease/src/ui/screens/map_page.dart';
import 'package:pharmaease/src/ui/screens/otp_screen.dart';
import 'package:pharmaease/src/ui/screens/sign_in_screen.dart';

import 'src/ui/screens/sign_up_screen.dart';
void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/':(context)=> SignUpScreen(),
        '/second':(context)=> OnBoardingScreen(),
      },
    );
  }
}
class LauncherScreen extends StatefulWidget {
  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}
class _LauncherScreenState extends State<LauncherScreen>{

  void initState(){
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.pushReplacementNamed(context, '/second');
    });
  }
  @override
  Widget build (BuildContext context){
    return Scaffold(
      backgroundColor:Colors.white,
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/pharmaease_logo.png",
              width:250,
              height: 250,
            ),
            SizedBox(
              height: 16,
            ),
            Text('PharmaEase?',style: Theme.of(context)
                .textTheme.headlineMedium
                ?.copyWith(fontWeight: FontWeight.w700,color:Color(0xFF199A8E),fontSize: 30)
          ,),
            SizedBox(height:16),

          ],
        ),
      )
    );
  }
}
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Text(
          'This is the second screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
