import 'dart:async';
import 'package:built_collection/src/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/cubits/alternative_drugs_cubit.dart';
import 'package:pharmaease/src/controller/cubits/nearest_pharmacies_at_startup_cubit.dart';
import 'package:pharmaease/src/controller/cubits/searched_drug_cubit.dart';
import 'package:pharmaease/src/controller/states/all_holding_pharmacies_state.dart';
import 'package:pharmaease/src/controller/states/alternative_drugs_state.dart';
import 'package:pharmaease/src/controller/states/searched_drug_state.dart';
import 'package:pharmaease/src/view/theme/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBarWidget extends StatefulWidget {
  final bool isFromSearchDrugScreen;

  const SearchBarWidget({Key? key, required this.isFromSearchDrugScreen})
      : super(key: key);

  @override
  State<SearchBarWidget> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBarWidget> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    String searchedDrug = _searchController.text;
    if (searchedDrug.isNotEmpty) {
      context.read<SearchedDrugCubit>().getSearchedDrug(searchedDrug, "");
      context.read<AlternativeDrugsCubit>().getSearchedDrug(searchedDrug, "");
    }
    if (searchedDrug.isEmpty || searchedDrug == null) {
      context.read<SearchedDrugCubit>().emit(InitialSearchedDrugState());
      context
          .read<AlternativeDrugsCubit>()
          .emit(InitialAlternativeDrugsState());
    }
  }

  void sendBarcodeOrName(String? barcode, BuiltList<String>? drugName) {
    if (widget.isFromSearchDrugScreen) {
      String searchedDrug = _searchController.text;
      if (searchedDrug.isNotEmpty) {
        context
            .read<SearchedDrugCubit>()
            .getSearchedDrug(searchedDrug, barcode);
        context
            .read<AlternativeDrugsCubit>()
            .getSearchedDrug(searchedDrug, barcode);
      } else if (barcode != null && barcode.isNotEmpty) {
        context.read<SearchedDrugCubit>().getSearchedDrug("", barcode);
        context.read<AlternativeDrugsCubit>().getSearchedDrug("", barcode);
      }
    } else {
      if (_searchController.text.isEmpty && barcode == null) {
        context
            .read<NearestPharmaciesAtStartupCubit>()
            .getUserLocationAutomaticallyAtStartup();
      } else {
        context
            .read<AllHoldingPharmaciesCubit>()
            .getBarcodeOrDrugName(barcode, drugName);
      }
    }
  }

  Future<void> scanBarcode(BuildContext context) async {
    if (_searchController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              "Please clear the search field before scanning the drug barcode")));
      return;
    }
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
    const IconData barcode = IconData(0xf586);
    if (!widget.isFromSearchDrugScreen) {
      return Positioned(
        left: 10,
        right: 10,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocListener<AllHoldingPharmaciesCubit,
              AllHoldingPharmaciesState>(
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
                    icon: const FaIcon(
                      FontAwesomeIcons.barcode,
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
    } else if (widget.isFromSearchDrugScreen) {
      return Positioned(
          left: 10,
          right: 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiBlocListener(
              listeners: [
                BlocListener<SearchedDrugCubit, SearchedDrugState>(
                  listener: (context, state) {
                    if (state is LoadedSearchedDrugState) {}
                    if (state is ErrorSearchedDrugState) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        "Failed to load Drugs",
                        style: TextStyle(color: Colors.red),
                      )));
                    }
                  },
                ),
                BlocListener<AlternativeDrugsCubit, AlternativeDrugsState>(
                  listener: (context, state) {
                    if (state is LoadedSearchedDrugState) {}
                    if (state is ErrorSearchedDrugState) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                        "Failed to load Drugs",
                        style: TextStyle(color: Colors.red),
                      )));
                    }
                  },
                ),
              ],
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
                          _onSearchChanged();
                        },
                      ),
                    ),
                    IconButton(
                      icon: const FaIcon(
                        FontAwesomeIcons.barcode,
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
          ));
    }
    return const Text("ERROR");
  }
}
