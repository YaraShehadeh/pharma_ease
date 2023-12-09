import'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class searchBar extends StatelessWidget {
  const searchBar({
    super.key,
  });

  Future<void> scanBarcode(BuildContext context) async {
    try {
      String scanningResult = await FlutterBarcodeScanner.scanBarcode(
        "#199A8E",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
      if (scanningResult == '-1') {
        return;
      }
      // You can use the scanningResult to perform further actions, e.g., search for the scanned medicine.
      print("Scanned barcode: $scanningResult");
      // You can navigate to a new screen or perform any other action based on the scanned result.
      // For example, you can search for the scanned medicine in your medicines list.
      // Medicine? scannedMedicine = medicines.firstWhereOrNull((medicine) => medicine.barcode == scanningResult);
      // if (scannedMedicine != null) {
      //   // Medicine found, you can navigate to a details screen or perform any other action.
      //   // For now, let's just print the details.
      //   print("Scanned Medicine Details: ${scannedMedicine.name}");
      // } else {
      //   // Medicine not found.
      //   print("Medicine not found");
      // }
    } catch (e) {
      print("Error scanning barcode: $e");
      // Handle errors, e.g., show a snackbar to the user.
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error scanning barcode: $e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 10,
      right: 10,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white
          ),
          child:  Row(
            children: [
              const Expanded(
                child:  TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),

                ),

              ),
              IconButton(
                icon: const Icon(Icons.camera_alt , color:pharmaGreenColor ,),
                onPressed: () {
                  scanBarcode(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}