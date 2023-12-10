import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/medicineSearch/medicine_card.dart';
import 'package:pharmaease/src/model/medicine_model.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/ui/widgets/search_bar_widget.dart';
import 'package:pharmaease/src/ui/widgets/side_menu.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class MedicineListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const String routeName = '/medicine_list';
  // Dummy data for medicines
  final List<Medicine> medicines = [
    Medicine(
        1,
        'Paracetamol',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
        "12 tablets",
        4,
        true,
        ['assets/images/onboarding_image_1.png']),
    Medicine(
        2,
        'Ibuprofen',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
        "3",
        9,
        false,
        ['assets/images/onboarding_image_1.png']),
    Medicine(
      3,
      'Cough Syrup',
      "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
      "4pcs",
      10,
      true,
      ['assets/images/onboarding_image_1.png'],
    ),
    Medicine(
        4,
        'Paracetamol',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
        "10 capsules",
        6,
        true,
        ['assets/images/onboarding_image_1.png']),
    Medicine(
        5,
        'Ibuprofen',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
        "2",
        1,
        true,
        ['assets/images/onboarding_image_1.png']),
    Medicine(
        6,
        'Cough Syrup',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
        "4",
        6,
        false,
        ['assets/images/onboarding_image_1.png']),
    Medicine(
        7,
        'Paracetamol',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
        "5",
        5,
        false,
        ['assets/images/onboarding_image_1.png']),
    Medicine(
        8,
        'Ibuprofen',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
        "10",
        4,
        false,
        ['assets/images/onboarding_image_1.png']),
    Medicine(
        9,
        'Cough Syrup',
        "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
        "3",
        2,
        false,
        ['assets/images/onboarding_image_1.png']),

    // Add more medicines as needed
  ];

  MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            if (_scaffoldKey.currentState != null) {
              _scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: pharmaGreenColor),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
            },
          ),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

      ),
      drawer: const Drawer(
        child: SideMenu(showSearchDrug: false,),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: medicines.length,
              itemBuilder: (context, index) {
                return MedicineCard(medicine: medicines[index]);
              },
            ),
          ),
          const Positioned(
            left: 10,
            right: 10,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: searchBar(),
            ),
          ),
        ],
      ),
    );
  }
}
