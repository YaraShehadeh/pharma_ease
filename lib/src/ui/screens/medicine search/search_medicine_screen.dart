import 'package:flutter/material.dart';
import'package:pharmaease/src/ui/screens/medicine search/medicine_card.dart';
import'package:pharmaease/src/ui/screens/medicine search/medicine_model.dart';
import 'package:pharmaease/src/ui/screens/map_page.dart';
import 'package:pharmaease/src/ui/screens/side_menu.dart';


class MedicineListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Dummy data for medicines
  final List<Medicine> medicines = [
    Medicine('Paracetamol', 'Pain reliever', 10.99, 'assets/images/onboarding_image_1.png',12,true),
    Medicine('Ibuprofen', 'Anti-inflammatory', 8.99, 'assets/images/onboarding_image_1.png',3,false),
    Medicine('Cough Syrup', 'Cough suppressant', 15.99, 'assets/images/onboarding_image_1.png',9,true),
    Medicine('Paracetamol', 'Pain reliever', 10.99, 'assets/images/onboarding_image_1.png',12,false),
    Medicine('Ibuprofen', 'Anti-inflammatory', 8.99, 'assets/images/onboarding_image_1.png',3,true),
    Medicine('Cough Syrup', 'Cough suppressant', 15.99, 'assets/images/onboarding_image_1.png',9,false),
    Medicine('Paracetamol', 'Pain reliever', 10.99, 'assets/images/onboarding_image_1.png',12,false),
    Medicine('Ibuprofen', 'Anti-inflammatory', 8.99, 'assets/images/onboarding_image_1.png',3,false),
    Medicine('Cough Syrup', 'Cough suppressant', 15.99, 'assets/images/onboarding_image_1.png',9,false),

    // Add more medicines as needed
  ];

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
        title:
            Text(
              '',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                icon:const Icon(Icons.home, color: Color(0xFF199A8E)),
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MapPage()));
                },
              ),
            ],




        backgroundColor: Colors.white,
      ),
      drawer:  Drawer(
        child: SideMenu(),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:60.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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