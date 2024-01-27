import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/cubits/nearest_pharmacies_at_startup_cubit.dart';
import 'package:pharmaease/src/controller/states/all_holding_pharmacies_state.dart';
import 'package:pharmaease/src/controller/states/nearest_pharmacies_at_startup_state.dart';
import 'package:pharmaease/src/view/screens/PharmacyScreens/all_pharmacies_screen.dart';
import 'package:pharmaease/src/view/screens/HomePage/map.dart';
import 'package:flutter/material.dart';
import 'package:pharmaease/src/view/screens/PharmacyScreens/pharmacy_details_screen.dart';
import 'package:pharmaease/src/view/theme/colors.dart';
import 'package:pharmaease/src/view/widgets/search_bar_widget.dart';
import 'package:pharmaease/src/view/widgets/side_menu.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<NearestPharmaciesAtStartupCubit>()
        .getUserLocationAutomaticallyAtStartup();
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
      drawer: Drawer(
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
                  _mapState.updateMarkers(activePharmacies);
                } else {
                  print("MapState not found");
                }
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
              final _mapState = mapKey.currentState;
              if (_mapState != null) {
                _mapState.updateMarkers(activePharmacies);
              }
            }
            if (state is NoHoldingPharmaciesFoundState) {
              setState(() {
                activePharmacies = [];
              });
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              child: PharmaciesBottomSheet(),
            ),
          ),
          const SearchBarWidget(),
        ],
      ),
    );
  }

  Widget PharmaciesBottomSheet() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text(
                  "Nearest Pharmacies",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 120),
                TextButton(
                  child: const Text("View all Pharmacies",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllPharmaciesScreen()));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: activePharmacies.length,
              itemBuilder: (context, index) {
                Pharmacy p = activePharmacies[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: pharmaGreenColor,
                    ),
                    child: ListTile(
                        title: Text(
                          p.pharmacyName.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        leading:
                            const Icon(Icons.pin_drop, color: Colors.white),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PharmacyDetailsScreen(
                                      showHomeIcon: false,
                                      pharmacyName: p.pharmacyName.toString(),
                                    )),
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
