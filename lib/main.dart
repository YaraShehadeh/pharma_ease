import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/all_pharmacies_cubit.dart';
import 'package:pharmaease/src/ui/screens/launcher_screen.dart';
import 'package:pharmaease/src/ui/screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AllPharmaciesCubit())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LauncherScreen(),
          '/second': (context) => const OnBoardingScreen(),
        },
      ),
    );
  }
}
