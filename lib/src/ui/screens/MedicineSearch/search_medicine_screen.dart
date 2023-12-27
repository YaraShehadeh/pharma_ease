// import 'package:flutter/material.dart';
// import 'package:pharmaease/src/ui/screens/MedicineSearch/medicine_card.dart';
// import 'package:pharmaease/src/ui/screens/medicineSearch/medicine_card.dart';
// import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
// import 'package:pharmaease/src/ui/widgets/search_bar_widget.dart';
// import 'package:pharmaease/src/ui/widgets/side_menu.dart';
// import 'package:pharmaease/src/ui/theme/colors.dart';
//
// class MedicineListScreen extends StatelessWidget {
//
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   static const String routeName = '/medicine_list';
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
//           const Padding(
//             padding: EdgeInsets.only(top: 60.0),
//             child: MedicineCard(),
//           ),
//           Positioned(
//             left: 10,
//             right: 10,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: searchBar(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
