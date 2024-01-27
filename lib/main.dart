import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease/src/controller/cubits/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/cubits/all_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/cubits/authentication_cubit.dart';
import 'package:pharmaease/src/controller/cubits/nearest_pharmacies_at_startup_cubit.dart';
import 'package:pharmaease/src/controller/cubits/pharmacy_details_cubit.dart';
import 'package:pharmaease/src/controller/cubits/sign_in_cubit.dart';
import 'package:pharmaease/src/controller/cubits/sign_up_cubit.dart';
import 'package:pharmaease/src/view/screens/OnboardingPages/launcher_screen.dart';
import 'package:pharmaease/src/view/screens/OnboardingPages/onboarding_screen.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

void main() {
  final api = PharmaeaseApi(
    // base connection with FastAPI
    basePathOverride: "http://10.0.2.2:8000",
  );
  final storage = FlutterSecureStorage();
  final getIt = GetIt.instance;
  // create a single instance of the model project [Client side library]
  getIt.registerSingleton<PharmaeaseApi>(api);
  getIt.registerSingleton<FlutterSecureStorage>(storage);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //create an instance of each cubit controller in the main class, this allows it to be accessible throughout the application
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AllPharmaciesCubit()),
        BlocProvider(create: (_)=> NearestPharmaciesAtStartupCubit()),
        BlocProvider(create: (_) => PharmacyDetailsCubit()),
        BlocProvider(create: (_) => AllHoldingPharmaciesCubit()),
        BlocProvider(create: (_) => SignInCubit()),
        BlocProvider(create: (_) => SignUpCubit()),
        BlocProvider(create: (_) => AuthenticationCubit())
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
