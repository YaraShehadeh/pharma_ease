import 'dart:async';

import 'package:built_collection/src/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/nearest_pharmacies_at_startup.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

class searchBar extends StatefulWidget {
  final Function(bool) onSearchChanged;
  const searchBar({Key? key,required this.onSearchChanged}) : super(key: key);


  @override
  State<searchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<searchBar> {
  TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState(){
    super.initState();
    _searchController.addListener((){
      widget.onSearchChanged(_searchController.text.isNotEmpty);
    });
  }
  @override
  void dispose(){
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void sendBarcodeOrName(String? barcode, BuiltList<String>? drugName) {
    context.read<AllHoldingPharmaciesCubit>().getBarcodeOrDrugName(barcode,drugName);
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



  //displays nearest pharmacies when search bar is cleared
  void _onSearchChanged(){
    // if (_debounce?.isActive ?? false) _debounce?.cancel();
    // _debounce = Timer(const Duration(milliseconds: 500), () {
    //   if (_searchController.text.isEmpty) {
    //     // The search bar is cleared, display nearest pharmacies
    //     BlocProvider.of<NearestPharmaciesAtStartupCubit>(context).getUserLocationAutomaticallyAtStartup();
    //   } else {
    //     // Search bar has input, perform the search
    //     sendBarcodeOrName(_searchController.text, null);
    //   }
    // });
    if(_searchController.text.isEmpty ){
      BlocProvider.of<NearestPharmaciesAtStartupCubit>(context).getUserLocationAutomaticallyAtStartup();
    }
  }

  @override
  Widget build(BuildContext context) {
        return Positioned(
          left: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child:BlocListener<AllHoldingPharmaciesCubit,AllHoldingPharmaciesState>(
                listener: (context,state){
                  if(state is LoadedAllHoldingPharmaciesState){
                    
                  }
                  if(state is ErrorAllHoldingPharmaciesState){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to load pharmacies",style: TextStyle(color:Colors.red),))
                    );
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
                            sendBarcodeOrName(null,BuiltList<String>([value]));
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
 
  }
}