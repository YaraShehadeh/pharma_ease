import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class MapPage extends StatefulWidget{
  @override
  _MapPage createState()=> _MapPage();
}
class _MapPage extends State<MapPage>{
  Completer<GoogleMapController> _controller = Completer();

  static const LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
    @override
    Widget build(BuildContext context){
      return Scaffold(
        appBar: AppBar(
          title: Text("Home page",style: TextStyle(color: Colors.black),),
        ),
        body:GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom:11.0,
          ),
        ),
      );
    }
  }


