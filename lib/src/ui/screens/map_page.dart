import 'dart:async';
import 'package:pharmaease/src/ui/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/pharmacy_details_screen.dart';
import 'package:pharmaease/src/ui/screens/side_menu.dart';

import '../widgets/search_bar_widget.dart';
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> listController = [];
  bool showDynamicSearchBars = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 0), () {
      _scaffoldKey.currentState!.showBottomSheet(
            (context) => ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
          child: Container(
            child: buildBottomSheetContent(context),
          ),
        ),
      );
    });
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
        title: const Text(
          'PharmaEase',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: const Drawer(
        child: SideMenu(),
      ),
      body: Center(
        child: Stack(
          children: <Widget>[
             Map(),
            if (showDynamicSearchBars)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Column(
                  children: [
                    for (int index = 0; index < listController.length; index++)
                      Row(
                        children: [
                          Expanded(child: searchBar()),
                          index != 0
                              ? GestureDetector(
                            onTap: () {
                              setState(() {
                                listController[index].clear();
                                listController[index].dispose();
                                listController.removeAt(index);
                              });
                            },
                            child: const Icon(
                              Icons.close,
                              color: Color(0xFF6B74D6),
                              size: 35,
                            ),
                          )
                              : const SizedBox()
                        ],
                      ),
                  ],
                ),
              ),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(child: searchBar()), // Static search bar
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showDynamicSearchBars = true;
                          listController.add(TextEditingController());
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.add, color: Color(0xFF199A8E)),
                      ),
                    ),
                  ],
                ),

            ),
          ],
        ),
      ),
    );
  }

  Widget buildBottomSheetContent(BuildContext context) {
    return SizedBox(
      height: 215,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  "Nearest Pharmacies",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  width: 100,
                ),
                Text("View all Pharmacies"),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              // pharmacyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xFF199A8E),
                    ),
                    child: ListTile(
                      title: Text("title"),
                      trailing: Text("trailing"),
                      leading: Icon(Icons.pin_drop),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PharmacyDetailsScreen(),
                          ),
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