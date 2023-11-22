import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/medicine search/medicine_model.dart';
import 'package:pharmaease/src/ui/screens/medicine_details_screen.dart';

class MedicineCard extends StatefulWidget {
  final Medicine medicine;

  MedicineCard({required this.medicine});

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:2.0,bottom: 2.0),
      child: Card(
        color: Colors.white,
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) =>MedicineDetailsScreen(medicine:Medicine(1,'Paracetamol',  "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.", "3pcs",4,true,['assets/images/onboarding_image_1.png']),)));
          },
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.asset(
                      widget.medicine.images[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.medicine.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${widget.medicine.perscription}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(Icons.local_pharmacy_outlined,color:  Color(0xFF199A8E),),
                        Text('${widget.medicine.pharmacies.toStringAsFixed(0)} pharmacies near you',style: TextStyle(fontSize: 10),)
                      ],
                    ),
                  ),
                ],
              ),

              if (widget.medicine.isConflicting)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

