import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/medicineSearch/medicine_card.dart';
import 'package:pharmaease/src/model/medicine_model.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/ui/widgets/side_menu.dart';

class MedicineListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Dummy data for medicines
  final List<DrugModel> medicines = [
    DrugModel(
        drugID: 1,
        drugName: 'Paracetamol',
        drugDescription:
            "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
        drugPerscription: "12 tablets",
        holdingPharmacies: 4,
        drugIsConflicting: true,
        drugImages: ['assets/images/onboarding_image_1.png']),
    DrugModel(
        drugID: 2,
        drugName: 'Paracetamol',
        drugDescription:
            "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
        drugPerscription: "12 tablets",
        holdingPharmacies: 4,
        drugIsConflicting: true,
        drugImages: ['assets/images/onboarding_image_1.png']),
    DrugModel(
        drugID: 3,
        drugName: 'Paracetamol',
        drugDescription:
            "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
        drugPerscription: "12 tablets",
        holdingPharmacies: 4,
        drugIsConflicting: true,
        drugImages: ['assets/images/onboarding_image_1.png']),
    DrugModel(
        drugID: 4,
        drugName: 'Paracetamol',
        drugDescription:
            "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
        drugPerscription: "12 tablets",
        holdingPharmacies: 4,
        drugIsConflicting: true,
        drugImages: ['assets/images/onboarding_image_1.png']),
    DrugModel(
        drugID: 5,
        drugName: 'Paracetamol',
        drugDescription:
            "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing",
        drugPerscription: "12 tablets",
        holdingPharmacies: 4,
        drugIsConflicting: true,
        drugImages: ['assets/images/onboarding_image_1.png']),
    // Add more medicines as needed
  ];

  MedicineListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            icon: const Icon(Icons.home, color: Color(0xFF199A8E)),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MapPage()));
            },
          ),
        ],
        backgroundColor: Colors.white,
      ),
      drawer: const Drawer(
        child: SideMenu(),
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
          Positioned(
            left: 10,
            right: 10,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.camera_alt,
                        color: Color(0xFF199A8E),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
