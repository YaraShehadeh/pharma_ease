import 'dart:async';
import 'package:built_collection/src/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/cubits/nearest_pharmacies_at_startup_cubit.dart';
import 'package:pharmaease/src/controller/states/all_holding_pharmacies_state.dart';
import 'package:pharmaease/src/view/theme/colors.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key}) : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();

  void sendBarcodeOrName(String? barcode, BuiltList<String>? drugName) {
    if (_searchController.text.isEmpty && barcode == null) {
      context.read<NearestPharmaciesAtStartupCubit>().getUserLocationAutomaticallyAtStartup();
    } else {
      context.read<AllHoldingPharmaciesCubit>().getBarcodeOrDrugName(barcode, drugName);
    }
  }

  Future<void> scanBarcode(BuildContext context) async {
    try {
      String scanningResult = await FlutterBarcodeScanner.scanBarcode(
        "#199A8E",
        "Cancel",
        true,
        ScanMode.BARCODE,
      );
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
        child:
            BlocListener<AllHoldingPharmaciesCubit, AllHoldingPharmaciesState>(
          listener: (context, state) {
            if (state is LoadedAllHoldingPharmaciesState) {}
            if (state is ErrorAllHoldingPharmaciesState) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                "Failed to load pharmacies",
                style: TextStyle(color: Colors.red),
              )));
            }
          },
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
                      sendBarcodeOrName(null, BuiltList<String>([value]));
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
      ),
    );
  }}
