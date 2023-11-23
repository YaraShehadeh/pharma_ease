import 'package:flutter/material.dart';
import'package:pharmaease/src/ui/screens/medicineSearch/medicine_card.dart';
import'package:pharmaease/src/model/medicine_model.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/ui/widgets/side_menu.dart';


class MedicineListScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // Dummy data for medicines
  final List<Medicine> medicines = [
    Medicine(1,'Paracetamol',  "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing", "12 tablets",4,true,['assets/images/onboarding_image_1.png']),
    Medicine(2,'Ibuprofen',  "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.","3",9 ,false,['assets/images/onboarding_image_1.png']),
    Medicine(3,'Cough Syrup',  "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.","4pcs",10, true, ['assets/images/onboarding_image_1.png'],),
    Medicine(4,'Paracetamol',  "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.", "10 capsules",6,true,['assets/images/onboarding_image_1.png']),
    Medicine(5,'Ibuprofen',  "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.","2",1 ,true,['assets/images/onboarding_image_1.png']),
    Medicine(6,'Cough Syrup', "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.","4",6, false,['assets/images/onboarding_image_1.png']),
    Medicine(7,'Paracetamol', "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.", "5",5 ,false,['assets/images/onboarding_image_1.png']),
    Medicine(8,'Ibuprofen', "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",  "10",4,false,['assets/images/onboarding_image_1.png']),
    Medicine(9,'Cough Syrup',  "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.","3",2,false,['assets/images/onboarding_image_1.png']),

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