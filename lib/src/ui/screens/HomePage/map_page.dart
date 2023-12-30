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

GlobalKey<MapState> mapKey=GlobalKey();
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<NearestPharmaciesAtStartupCubit>().getUserLocationAutomaticallyAtStartup();
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
  }

  void _showBottomSheet(BuildContext context, List<Pharmacy> pharmacies) {
    var state = context.read<NearestPharmaciesAtStartupCubit>().state;
    if (state is LoadedNearestPharmaciesAtStartupState) {
      _scaffoldKey.currentState!.showBottomSheet(
            (context) => ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: Container(
            child: buildBottomSheetContent(context, state.pharmacies),
          ),
        ),
        enableDrag: false,
      );
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
      drawer: const Drawer(
        child: SideMenu(showSearchDrug: true,),
      ),
      body: BlocConsumer<NearestPharmaciesAtStartupCubit,NearestPharmaciesAtStartupState>(
        builder: (context, state) {
          List<Pharmacy> pharmacies = [];
          if (state is LoadedNearestPharmaciesAtStartupState) {
            pharmacies = state.pharmacies;
          }
          return Center(
            child: Stack(
              children: <Widget>[
                 Map(key: mapKey,),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    child: buildBottomSheetContent(context,pharmacies),
                  ),
                ),
                const searchBar(),
              ],
            ),
          );
        }, listener: ( context, state) {
          if(state is LoadedNearestPharmaciesAtStartupState){
            _showBottomSheet(context,state.pharmacies);
            final _mapState = mapKey.currentState;
            if(_mapState!=null){
            _mapState?.updateMarkers(state.pharmacies);
          }
            else{
            print("MapState not found");}
          }
          const Text("Loading");
      },
      ),
    );
  }

  Widget buildBottomSheetContent(BuildContext context,List<Pharmacy>pharmacies) {
    return SizedBox(
      height: MediaQuery.of(context).size.height*0.25,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
           Padding(
            padding: EdgeInsets.all(8.0),
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
                      child:Text("View all Pharmacies",style:TextStyle(color: Colors.black)),
                    onPressed: () {
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context) => AllPharmaciesScreen()));},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: pharmacies.length,
              // pharmacyList.length,
              itemBuilder: (context, index) {
                Pharmacy pharmacy=pharmacies[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: pharmaGreenColor,
                    ),
                    child: ListTile(
                      title:  Text(pharmacy.pharmacyName.toString()),
                      trailing: const Text("trailing"),
                      leading: const Icon(Icons.pin_drop),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                   PharmacyDetailsScreen(showHomeIcon: false,pharmacyName: pharmacy.pharmacyName.toString(),)),
                          // title: Text(pharmacyList[index]["title"] ?? ""),
                          // trailing: Text(pharmacyList[index]["trailing"] ?? ""),
                          // leading: Icon(Icons.pin_drop),
                        );
                      },
                    ),
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
