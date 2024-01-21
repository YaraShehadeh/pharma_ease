import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pharmaease/src/controller/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/all_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/alternative_drugs_cubit.dart';
import 'package:pharmaease/src/controller/chatbot_cubit.dart';
import 'package:pharmaease/src/controller/drug_details_cubit.dart';
import 'package:pharmaease/src/controller/nearest_pharmacies_at_startup.dart';
import 'package:pharmaease/src/controller/pharmacy_details_cubit.dart';
import 'package:pharmaease/src/controller/searched_drug_cubit.dart';
import 'package:pharmaease/src/ui/screens/chatbot_screen.dart';
import 'package:pharmaease/src/ui/screens/launcher_screen.dart';
import 'package:pharmaease/src/ui/screens/onboarding_screen.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

void main() {
  final api = PharmaeaseApi(
    //Base connection with FastAPI
    basePathOverride: "http://10.0.2.2:8000",
  );
  api.dio.options.connectTimeout=const Duration(seconds: 10);
  api.dio.options.receiveTimeout=const Duration(seconds: 20);
  final getIt = GetIt.instance;
  //Creating a single instance of the Model project [Client-side library]
  getIt.registerSingleton<PharmaeaseApi>(api);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Creating an instance of each cubit controller in the main class, this allows it to be accessible throughout the app
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AllPharmaciesCubit()),
        BlocProvider(create: (_)=> NearestPharmaciesAtStartupCubit()),
        BlocProvider(create: (_) => PharmacyDetailsCubit()),
        BlocProvider(create: (_) => AllHoldingPharmaciesCubit()),
        BlocProvider(create: (_)=> DrugDetailsCubit()),
        BlocProvider(create: (_)=> SearchedDrugCubit()),
        BlocProvider(create: (_)=> AlternativeDrugsCubit()),
        BlocProvider(create: (_)=> ChatBotCubit())
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
