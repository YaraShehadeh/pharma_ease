import 'package:flutter/material.dart';
import'package:pharmaease/src/ui/screens/medicine search/medicine_card.dart';
import'package:pharmaease/src/ui/screens/medicine search/medicine_model.dart';


class MedicineListScreen extends StatelessWidget {
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
        title: Text('Medicine Store'),
      ),
      body: GridView.builder(
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
    );
  }
}
