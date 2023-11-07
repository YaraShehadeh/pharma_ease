import 'dart:async';
import 'package:pharmaease/src/ui/screens/map.dart';
import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/side_menu.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PersistentBottomSheetController? _bottomSheetController;

  // List<Map<String, String>> pharmacyList = [
  //   {"title": "Pharmacy 1", "trailing": "6 mins"},
  //   {"title": "Pharmacy 2", "trailing": "4 mins"},
  //   {"title": "Pharmacy 3", "trailing": "8 mins"},
  //   {"title": "Pharmacy 4", "trailing": "8 mins"},
  // ];

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 0), () {
      _bottomSheetController = _scaffoldKey.currentState!.showBottomSheet(
            (context) =>
            ClipRRect(
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
        leading: IconButton(
          icon:Icon(Icons.menu), color: Colors.black,
        onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        },),
      title: Row(children: [

        Text('PharmaEase', style: TextStyle(color: Colors.black),),
      ],),
      backgroundColor: Colors.white,
    )
    ,
    drawer: Drawer(
    child: SideMenu(),
    ),
    body: Center(
    child:
    Stack(children:<Widget>[ Map(),
    Positioned(
    bottom: 0,
    left: 0,
    right: 0,
    child: Container(
    color: Colors.transparent, // Adjust the color as needed
    child: buildBottomSheetContent(context),
    ),
    ),
    // Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 25),
    //   child: InkWell(
    //     onTap:(){},
    //     borderRadius: BorderRadius.circular(40),
    //     child: TextField(
    //       decoration: InputDecoration(
    //         hintText:"WTF",
    //         filled: true,
    //         fillColor: Colors.black.withOpacity(0.22),
    //         enabled: false,
    //         disabledBorder: UnderlineInputBorder(
    //           borderSide: BorderSide.none,
    //           borderRadius: BorderRadius.circular(40),
    //         ),
    //         hintStyle: Theme.of(context)
    //             .textTheme
    //             .headlineMedium!
    //             .copyWith(fontSize:2, color: Colors.black),
    //       ),
    //     ),
    //   ),),
    ],
    ),
    ),
    );
  }

  Widget buildBottomSheetContent(BuildContext context) {
    return SizedBox(
      height: 200, // Set a finite height for the BottomSheet content
      child: Column(
        children: <Widget>[
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("Nearest Pharmacies",
                  style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(width: 100,),
                Text("View all Pharmacies"),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Expanded( // Use Expanded widget to take remaining space
            child: ListView.builder(
              itemCount: 5,
              // pharmacyList.length,
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
                      title: Text("title"),
                      trailing: Text("trailing"),
                      leading: Icon(Icons.pin_drop),
                      // title: Text(pharmacyList[index]["title"] ?? ""),
                      // trailing: Text(pharmacyList[index]["trailing"] ?? ""),
                      // leading: Icon(Icons.pin_drop),
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