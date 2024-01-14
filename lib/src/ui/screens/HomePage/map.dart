import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as location;
import 'package:pharmaease/src/ui/theme/colors.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class Map extends StatefulWidget {
 final  Function(Pharmacy)? onPharmacySelected;
   Map({super.key,this.onPharmacySelected});

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  late Set<Marker> markers;
  static const _initialCameraPosition =
  CameraPosition(target: LatLng(31.963158, 35.930359), zoom: 10);
  late GoogleMapController _googleMapController;
  final location.Location _locationController = location.Location();



  void _onMarkerTapped(Pharmacy pharmacy){
    widget.onPharmacySelected?.call(pharmacy);
  }

  @override
  void initState() {
    super.initState();
    markers = Set<Marker>();
    getLocationUpdates();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }


  void updateMarkers(List<Pharmacy>pharmacies){
      setState(() {
        markers.clear();
        if(pharmacies.isNotEmpty) {
          int markerId = 0;
          markers = pharmacies.map((pharmacy) {
            markerId++;
            String uniqueId = "pharmacy_${markerId}";
            return Marker(
              markerId: MarkerId(uniqueId),
              position: LatLng(
                double.parse(pharmacy.location.latitude.toString()),
                double.parse(pharmacy.location.longitude.toString()),),
              //position: LatLng(32.0006533,35.8879917),
              infoWindow: InfoWindow(title: pharmacy.pharmacyName.toString()),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () => _onMarkerTapped(pharmacy),
            );
          }).toSet();
        }
         });

     _updateCameraPosition(pharmacies);
       }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: Set.from(markers),
      ),
    );
  }

  Future<void> getLocationUpdates() async {
    bool _serviceEnabled;
    location.PermissionStatus _permissionGranted;
    _serviceEnabled = await _locationController.serviceEnabled();
    if (_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
    } else {
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == location.PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != location.PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged
        .listen((location.LocationData currentLocation) {
      if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
        setState(() {
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: LatLng(
                      currentLocation.latitude!, currentLocation.longitude!),
                  zoom: 16)));
        });
      }
    });
  }

  //MODIFY THIS MAKE SURE IT WORKS
  void _updateCameraPosition(List<Pharmacy> pharmacies) {
    if (pharmacies.isEmpty) return;

    double minLat = pharmacies.first.location.latitude as double;
    double maxLat = pharmacies.first.location.latitude as double;
    double minLong = pharmacies.first.location.longitude as double;
    double maxLong = pharmacies.first.location.longitude as double;

    for (var pharmacy in pharmacies) {
      minLat = min(minLat, pharmacy.location.latitude as double);
      maxLat = max(maxLat, pharmacy.location.latitude as double);
      minLong = min(minLong, pharmacy.location.longitude as double);
      maxLong = max(maxLong, pharmacy.location.longitude as double);
    }
    _googleMapController.animateCamera(
      CameraUpdate.newLatLngBounds(
          LatLngBounds(southwest: LatLng(minLat, minLong),
            northeast: LatLng(maxLat, maxLong),),
          100.0),
    );
  }
}
