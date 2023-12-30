import 'package:built_collection/src/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pharmaease/src/controller/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class searchBar extends StatefulWidget {
  const searchBar({Key? key}) : super(key: key);

  @override
  State<searchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<searchBar> {
  TextEditingController _searchController = TextEditingController();

  void sendBarcodeOrName(String? barcode, BuiltList<String>? drugName) {
    AllHoldingPharmaciesCubit cubit = AllHoldingPharmaciesCubit();
    cubit.getBarcodeOrDrugName(barcode, drugName);
  }

  Future<void> scanBarcode(BuildContext context) async {
    try {
      String scanningResult = await FlutterBarcodeScanner.scanBarcode(
        "#199A8E",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
      print("==scanningResult");
      print(scanningResult);
      sendBarcodeOrName(scanningResult, null);
    } catch (e) {
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
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: "Search...",
                    prefixIcon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) {
                    sendBarcodeOrName(null, value as BuiltList<String>?);
                  },
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.camera_alt,
                  color: pharmaGreenColor,
                ),
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