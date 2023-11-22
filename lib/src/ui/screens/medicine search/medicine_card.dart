import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/medicine search/medicine_model.dart';

class MedicineCard extends StatefulWidget {
  final Medicine medicine;

  MedicineCard({required this.medicine});

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Implement navigation to a detailed medicine page
          // You can use Navigator.push() to navigate to a new screen
          // and pass the selected medicine to the new screen.
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Image.asset(
                    widget.medicine.imagePath,
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
                  child: Text('\$${widget.medicine.price.toStringAsFixed(2)}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Icon(Icons.local_pharmacy_outlined,color:  Color(0xFF199A8E),),
                      Text('\$${widget.medicine.pharmacies.toStringAsFixed(2)} pharmacies near you',style: TextStyle(fontSize: 10),)
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
    );
  }
}

