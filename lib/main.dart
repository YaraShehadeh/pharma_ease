import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease/src/controller/all_pharmacies_cubit.dart';
import 'package:pharmaease/src/ui/screens/launcher_screen.dart';
import 'package:pharmaease/src/ui/screens/onboarding_screen.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

void main() {
  final api = PharmaeaseApi(
    basePathOverride: "http://10.0.2.2:8000",
  );
  final getIt = GetIt.instance;
  getIt.registerSingleton<PharmaeaseApi>(api);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AllPharmaciesCubit())],
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
