// import 'package:bloc/bloc.dart';
// import 'package:dio/dio.dart';
// import 'package:get_it/get_it.dart';
// import 'package:pharmaease_api/pharmaease_api.dart';
//
// class SearchedDrugCubit extends Cubit<SearchedDrugState> {
//   List<Drug> drugs = [];
//   final PharmaeaseApi _api = GetIt.I.get<PharmaeaseApi>();
//
//   SearchedDrugCubit(String drugName) : super(InitialSearchedDrugState()) {
//     getSearchedDrugs(drugName);
//   }
//
//   Future<void> getSearchedDrug(String drugName) async {
//     try {
//       emit(LoadingSearchedDrugState());
//       List<Drug>? result = (await _api
//           .getDrugApi()
//           .getDrugByNameApiDrugDrugnameDrugNameGet(drugName: drugName))
//           .data!.toList();
//       if (result == null) {
//         emit(ErrorSearchedDrugState());
//       } else {
//         drugs = result;
//         emit(LoadedSearchedDrugState());
//       }
//     } on DioException catch (e) {
//       if (e.response!.statusCode == 401) {
//         emit(ErrorSearchedDrugState());
//         print("Error: $e");
//         throw Exception("Drug not found");
//       }
//     }
//   }
// }
//
// abstract class SearchedDrugState {}
//
// class InitialSearchedDrugState extends SearchedDrugState {}
//
// class LoadingSearchedDrugState extends SearchedDrugState {}
//
// class LoadedSearchedDrugState extends SearchedDrugState {}
//
// class ErrorSearchedDrugState extends SearchedDrugState {}