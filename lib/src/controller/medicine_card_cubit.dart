// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pharmaease_api/pharmaease_api.dart';
//
// class DrugCubit extends Cubit<DrugState> {
//   DrugCubit(String drugName) : super(InitialDrugState()) {
//     getMedicineCard(drugName);
//   }
//
//   List<Drug> drugs = [];
//   final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();
//
//   Future<dynamic> getMedicineCard(String drugName) async {
//     try {
//       emit(LoadingDrugState());
//       List<Drug>? result = (await _api
//               .getDrugApi()
//               .getDrugByNameApiDrugDrugnameDrugNameGet(drugName: drugName))
//           .data!
//           .toList();
//       if (result == null) {
//         emit(ErrorDrugState());
//         return;
//       } else {
//         drugs = result;
//         emit(LoadingDrugState());
//         return;
//       }
//     } on DioException catch (e) {
//       if (e.response!.statusCode == 401) {
//         emit(ErrorDrugState());
//         print("Error: $e");
//         throw Exception("Drug not found");
//       }
//     }
//   }
// }
//
// abstract class DrugState {}
//
// class InitialDrugState extends DrugState {}
//
// class LoadingDrugState extends DrugState {}
//
// class LoadedDrugState extends DrugState {}
//
// class ErrorDrugState extends DrugState {}
