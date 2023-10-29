import 'dart:async';

import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map<String, String>> pharmacyList = [
    {"title": "Pharmacy 1", "trailing": "6 mins"},
    {"title": "Pharmacy 2", "trailing": "4 mins"},
    {"title": "Pharmacy 3", "trailing": "8 mins"},
    {"title": "Pharmacy 4", "trailing": "8 mins"},
  ];

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 0), () {
      _scaffoldKey.currentState!.showBottomSheet(
            (context) => ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
          child: Container(
            color: Colors.grey,
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
        title: Text('Map Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }

  Widget buildBottomSheetContent(BuildContext context) {
    return Container(
      height: 250, // Set a finite height for the BottomSheet content
      child: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Nearest Pharmacies", style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(width: 100,),
                Text("View all Pharmacies"),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Expanded( // Use Expanded widget to take remaining space
            child: ListView.builder(
              itemCount: pharmacyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0xFF199A8E),
                    ),
                    child: ListTile(
                      title: Text(pharmacyList[index]["title"] ?? ""),
                      trailing: Text(pharmacyList[index]["trailing"] ?? ""),
                      leading: Icon(Icons.pin_drop),
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
