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
import 'package:scroll_to_index/scroll_to_index.dart';

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
  Pharmacy? selectedPharmacy;
  final AutoScrollController scrollController = AutoScrollController();
  bool noHoldingPharmaciesFound= false;

  @override
  void initState() {
    super.initState();
    context.read<NearestPharmaciesAtStartupCubit>()
        .getUserLocationAutomaticallyAtStartup();
  }

  void onPharmacySelected(Pharmacy pharmacy) {
    int index = activePharmacies.indexOf(pharmacy);
    if (index != -1) {
      setState(() {
        selectedPharmacy = pharmacy;
      });
      scrollController.scrollToIndex(index * 100000000,
          preferPosition: AutoScrollPosition.middle);
    }
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
                  noHoldingPharmaciesFound=false;
                });
                final _mapState = mapKey.currentState;
                if (_mapState != null) {
                  _mapState.updateMarkers(activePharmacies);
                }
              }
              if (state is LoadingNearestPharmaciesAtStartupState) {
                const Center(child: CircularProgressIndicator());
              }
              const Text("Loading");
            },
          ),
          BlocListener<AllHoldingPharmaciesCubit, AllHoldingPharmaciesState>(
              listener: (context, state) {
            if (state is LoadedAllHoldingPharmaciesState) {
              setState(() {
                activePharmacies = state.pharmacies;
                noHoldingPharmaciesFound=false;
              });
              final _mapState = mapKey.currentState;
              if (_mapState != null) {
                _mapState.updateMarkers(activePharmacies);
              }
            }
            if (state is NoHoldingPharmaciesFoundState) {
              setState(() {
               noHoldingPharmaciesFound=true;
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
            onPharmacySelected: onPharmacySelected,
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
          const SearchBarWidget(
            isFromSearchDrugScreen: false,
          ),
        ],
      ),
    );
  }

  Widget PharmaciesBottomSheet() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      height: noHoldingPharmaciesFound? screenHeight*0.15: screenHeight * 0.25,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                 Text(
                   noHoldingPharmaciesFound?"":"Nearest Pharmacies",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                 SizedBox(width:noHoldingPharmaciesFound?screenWidth*0.5:screenWidth*0.234),
                TextButton(
                  child: const Text("View all Pharmacies",
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllPharmaciesScreen(drugName: null,)));
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          noHoldingPharmaciesFound? Text("No pharmacies holding that drug",style: TextStyle(fontWeight: FontWeight.w500),):
          Expanded(
            child: ListView.builder(
              itemCount: activePharmacies.length,
              itemBuilder: (context, index) {
                Pharmacy pharmacy = activePharmacies[index];
                bool isSelected =
                    selectedPharmacy != null && selectedPharmacy == pharmacy;

                return AutoScrollTag(
                    key: ValueKey(index),
                    controller: scrollController,
                    index: index * 10,
                    child: PharmacyListItem(pharmacy, isSelected));
              },
            ),
          ),
        ],
      ),
    );


  }

  Widget PharmacyListItem(Pharmacy p, bool isSelected) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: isSelected ? Colors.blue : pharmaGreenColor,
        ),
        child: ListTile(
            title: Text(
              p.pharmacyName.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            leading: const Icon(Icons.pin_drop, color: Colors.white),
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
  }
}
