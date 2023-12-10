// import 'package:flutter/material.dart';
// import 'package:pharmaease/src/ui/screens/medicineSearch/medicine_card.dart';
// import 'package:pharmaease/src/model/medicine_model.dart';
// import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
// import 'package:pharmaease/src/ui/widgets/search_bar_widget.dart';
// import 'package:pharmaease/src/ui/widgets/side_menu.dart';
// import 'package:pharmaease/src/ui/theme/colors.dart';
//
// class MedicineListScreen extends StatelessWidget {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   static const String routeName = '/medicine_list';
//   // Dummy data for medicines
//   final List<DrugModel> medicines = [
//     DrugModel(
//         drugID: 1,
//         drugName: 'Paracetamol',
//         drugDescription:
//             "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
//         drugPerscription: "12 tablets",
//         holdingPharmacies: 4,
//         drugIsConflicting: true,
//         drugImages: ['assets/images/onboarding_image_1.png']),
//     DrugModel(
//         drugID: 2,
//         drugName: 'Paracetamol',
//         drugDescription:
//             "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
//         drugPerscription: "12 tablets",
//         holdingPharmacies: 4,
//         drugIsConflicting: true,
//         drugImages: ['assets/images/onboarding_image_1.png']),
//     DrugModel(
//         drugID: 3,
//         drugName: 'Paracetamol',
//         drugDescription:
//             "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
//         drugPerscription: "12 tablets",
//         holdingPharmacies: 4,
//         drugIsConflicting: true,
//         drugImages: ['assets/images/onboarding_image_1.png']),
//     DrugModel(
//         drugID: 4,
//         drugName: 'Paracetamol',
//         drugDescription:
//             "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
//         drugPerscription: "12 tablets",
//         holdingPharmacies: 4,
//         drugIsConflicting: true,
//         drugImages: ['assets/images/onboarding_image_1.png']),
//     DrugModel(
//         drugID: 5,
//         drugName: 'Paracetamol',
//         drugDescription:
//             "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
//         drugPerscription: "12 tablets",
//         holdingPharmacies: 4,
//         drugIsConflicting: true,
//         drugImages: ['assets/images/onboarding_image_1.png']),
//     // Add more medicines as needed
//   ];
//
//   MedicineListScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           color: Colors.black,
//           onPressed: () {
//             if (_scaffoldKey.currentState != null) {
//               _scaffoldKey.currentState!.openDrawer();
//             }
//           },
//         ),
//         title: const Text(
//           '',
//           style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.home, color: pharmaGreenColor),
//             onPressed: () {
//               Navigator.pushReplacement(
//                   context, MaterialPageRoute(builder: (context) => MapPage()));
//             },
//           ),
//         ],
//         backgroundColor: Colors.white,
//         surfaceTintColor: Colors.white,
//
//       ),
//       drawer: const Drawer(
//         child: SideMenu(showSearchDrug: false,),
//       ),
//       body: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(top: 60.0),
//             child: GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//               itemCount: medicines.length,
//               itemBuilder: (context, index) {
//                 return MedicineCard(medicine: medicines[index]);
//               },
//             ),
//           ),
//           const Positioned(
//             left: 10,
//             right: 10,
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: searchBar(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
