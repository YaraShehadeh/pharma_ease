import 'dart:async';
import 'package:built_collection/src/list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/nearest_pharmacies_at_startup.dart';
import 'package:pharmaease/src/ui/screens/AllPharmaciesScreen.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map.dart';
import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/pharmacy_details_screen.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';
import 'package:pharmaease/src/ui/widgets/search_bar_widget.dart';
import 'package:pharmaease/src/ui/widgets/side_menu.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

GlobalKey<MapState> mapKey = GlobalKey();

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<MapState> mapKey = GlobalKey();
  List<Pharmacy> activePharmacies = [];
  bool _showBottomSheetFlag=true;

  @override
  void initState() {
    super.initState();
    _setShowBottomSheet(false);
    context
        .read<NearestPharmaciesAtStartupCubit>()
        .getUserLocationAutomaticallyAtStartup().then((_){
          _setShowBottomSheet(true);});
    }
    // Timer(const Duration(seconds: 0), () {
    //   _scaffoldKey.currentState!.showBottomSheet(
    //     (context) => ClipRRect(
    //       borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
    //       child: Container(
    //         child: buildBottomSheetContent(context),
    //       ),
    //     ),
    //     enableDrag: false,
    //   );
    // });


  void _showBottomSheet(BuildContext context, List<Pharmacy> pharmacies) {
    _scaffoldKey.currentState!.showBottomSheet(
      (context) => ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        child: Container(
          child: buildBottomSheetContent(context, pharmacies),
        ),
      ),
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
        title: const Row(
          children: [
            Text(
              'PharmaEase',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      drawer: const Drawer(
        child: SideMenu(
          showSearchDrug: true,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<NearestPharmaciesAtStartupCubit,
              NearestPharmaciesAtStartupState>(
            listener: (context, state) {
              if (state is LoadedNearestPharmaciesAtStartupState) {
                setState(() {
                  activePharmacies = state.pharmacies;
                });
                final _mapState = mapKey.currentState;
                if (_mapState != null) {
                  _mapState?.updateMarkers(activePharmacies);
                } else {
                  print("MapState not found");
                }
                if(_showBottomSheetFlag)
                _showBottomSheet(context, activePharmacies);
              }
              if (state is LoadingNearestPharmaciesAtStartupState) {
                print("LOADINGGGGG");
              }
              const Text("Loading");
            },
          ),
          BlocListener<AllHoldingPharmaciesCubit, AllHoldingPharmaciesState>(
              listener: (context, state) {
            if (state is LoadedAllHoldingPharmaciesState) {
              setState(() {
                activePharmacies = state.pharmacies;
              });
              _showBottomSheet(context, activePharmacies);
              final _mapState = mapKey.currentState;
              if (_mapState != null) {
                _mapState?.updateMarkers(activePharmacies);
              }
            }
            if (state is NoHoldingPharmaciesFoundState) {
              setState(() {
                activePharmacies = [];
              });
              if(_showBottomSheetFlag)
              _showBottomSheet(context, activePharmacies);
              final _mapState = mapKey.currentState;
              if (_mapState != null) {
                _mapState.updateMarkers([]);
              }
            }
          })
        ],
        child: buildUIWithPharmacies(activePharmacies),
      ),
    );
  }

  Widget buildUIWithPharmacies(List<Pharmacy> pharmacies) {
    return Center(
      child: Stack(
        children: <Widget>[
          Map(
            key: mapKey,
          ),
          if(_showBottomSheetFlag)
            Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: buildBottomSheetContent(context, pharmacies),
            ),
          ),
           searchBar(onSearchChanged: (isTyping){
            _setShowBottomSheet(!isTyping);
           },),
        ],
      ),
    );
  }
  void _setShowBottomSheet(bool value){
    setState(() {
      _showBottomSheetFlag=value;
    });
  }

  Widget buildBottomSheetContent(
      BuildContext context, List<Pharmacy> pharmacies) {
    print("BOTTOM SHEET PHARMACIES");
    print(pharmacies);
    print("${pharmacies.length}");
    return SizedBox(
      height: pharmacies.isNotEmpty
          ? MediaQuery.of(context).size.height * 0.25
          : MediaQuery.of(context).size.height * 0.19,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: pharmacies.isNotEmpty
                ? EdgeInsets.all(8.0)
                : EdgeInsets.only(left: 8, bottom: 2),
            child: Row(
              children: [
                Text(
                  "Nearest Pharmacies",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                // SizedBox(
                //   width: 100,
                // ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextButton(
                    child: Text("View all Pharmacies",
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllPharmaciesScreen()));
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          if (pharmacies.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemCount: pharmacies.length,
                itemBuilder: (context, index) {
                  Pharmacy pharmacy = pharmacies[index];
                  if (pharmacies.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: pharmaGreenColor,
                        ),
                        child: ListTile(
                          title: Text(pharmacy.pharmacyName.toString()),
                          trailing: const Text("trailing"),
                          leading: const Icon(Icons.pin_drop),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PharmacyDetailsScreen(
                                        showHomeIcon: false,
                                        pharmacyName:
                                            pharmacy.pharmacyName.toString(),
                                      )),
                              // title: Text(pharmacyList[index]["title"] ?? ""),
                              // trailing: Text(pharmacyList[index]["trailing"] ?? ""),
                              // leading: Icon(Icons.pin_drop),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          if (pharmacies.isEmpty)
            Container(
                height: 25,
                child: Center(
                  child: Text("No Pharmacies holding that drug",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ))
        ],
      ),
    );
  }
}
