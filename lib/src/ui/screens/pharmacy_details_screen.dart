import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/pharmacy_details_cubit.dart';
import 'package:pharmaease/src/ui/screens/AllPharmaciesScreen.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

import 'package:pharmaease/src/controller/location_service.dart';
import 'package:pharmaease/src/controller/pharmacy_services.dart';

class PharmacyDetailsScreen extends StatefulWidget {
  bool showHomeIcon = false;
  String pharmacyName;
  String? searchedDrug;
  //final GlobalKey<MapState> mapKey;

  PharmacyDetailsScreen(
      {super.key, required this.showHomeIcon, required this.pharmacyName, this.searchedDrug});

  @override
  State<StatefulWidget> createState() => _PharmacyDetailsScreenState();
}

class _PharmacyDetailsScreenState extends State<PharmacyDetailsScreen> {

  double? _distanceToPharmacy;
  int? _travelTime;
  final LocationService _locationService = LocationService();
  final PharmacyService _pharmacyService= PharmacyService();


  @override
  void initState() {
    super.initState();
    _calculateAndDisplayDistance();
    Future.delayed(Duration.zero, () {
      context
          .read<PharmacyDetailsCubit>()
          .getPharmacyInformation(widget.pharmacyName);
    });
  }

  void _calculateAndDisplayDistance() async {
    final userLocation = await _locationService.getCurrentLocation();
    if (userLocation != null) {
      final pharmacy = context.read<PharmacyDetailsCubit>().pharmacy;
      if (pharmacy != null) {
        final distance = await _pharmacyService.calculateDistance(
            userLocation.latitude!,
            userLocation.longitude!,
            double.parse(pharmacy.location.latitude.toString()),
            double.parse(pharmacy.location.longitude.toString()));

        setState(() {
          _distanceToPharmacy =
              distance / 1000; //converts distance to Kilometers
          _travelTime = _pharmacyService.calculateTravelTime(_distanceToPharmacy!, 5);
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    double width= MediaQuery.of(context).size.width;
    double height= MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              if (widget.showHomeIcon && widget.searchedDrug==null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AllPharmaciesScreen()));
              }
              else if(widget.showHomeIcon==false && widget.searchedDrug!=null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  AllPharmaciesScreen(drugName: widget.searchedDrug,)));
              }
              else {
                Navigator.pop(context);
              }
            },
            color: Colors.black26,
          ),
          actions: <Widget>[
            if (widget.showHomeIcon)
              IconButton(
                icon: const Icon(Icons.home),
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                color: const Color.fromRGBO(25, 154, 142, 100),
                iconSize: 30,
              ),
          ],
          elevation: 0,
        ),
        body: BlocConsumer<PharmacyDetailsCubit, PharmacyDetailsState>(
          builder: (context, state) {
            if (state is LoadedPharmacyDetailsState) {
              final pharmacy = state.pharmacy;
              if (pharmacy != null) {
                return Padding(
                  padding:  EdgeInsets.all(width*0.05),
                  child: Column(
                    children: [
                      Text(pharmacy!.pharmacyName.toString(),
                          style:  TextStyle(
                            fontSize: width*0.06,
                          )),
                       SizedBox(height: height*0.03),
                      const Image(
                        image: AssetImage('assets/images/aster.png'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              if(pharmacy.location!=null){
                                _pharmacyService.launchGoogleMaps(
                                double.parse(pharmacy.location.latitude.toString()),
                                    double.parse(pharmacy.location.longitude.toString()));
                              }
                            },
                            child: const Row(
                              children: [
                                const Icon(
                                  Icons.pin_drop,
                                  color: pharmaGreenColor,
                                ),
                                SizedBox(width: 5,),
                                Text("Directions"),
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              _pharmacyService.launchPhone(
                                  pharmacy.pharmacyPhoneNumber.toString());
                            },
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.call_outlined,
                                    color: pharmaGreenColor,
                                  ),
                                ),
                                const Text("Call"),
                              ],
                            ),
                          ),

                        ],
                      ),

                      Row(children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.location_on_outlined),
                        ),
                        if (_distanceToPharmacy != null && _travelTime != null)
                          Text(
                              "${_distanceToPharmacy!.toStringAsFixed(2)} KM away from you",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w500,)),
                      ]),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.access_time_outlined)),
                            Text("${_travelTime} ${ _travelTime==1?" minute away": "minutes away"}",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.w500,)),
                          ],
                        ),



                      const Divider(
                        thickness: 0.6,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.location_on,
                                color: pharmaGreenColor),
                            onPressed: () {},
                            color: const Color.fromRGBO(25, 154, 142, 100),
                            iconSize: 30,
                          ),
                           Text(
                            "Address",
                              style: TextStyle(fontSize: width*0.04,fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(pharmacy.pharmacyArea.toString(),style: TextStyle(fontSize: width*0.04)),
                      const Divider(thickness: 0.6, color: Colors.black),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.description,
                                color: pharmaGreenColor),
                            onPressed: () {},
                            iconSize: 26,
                          ),
                           Text(
                            "Description",
                            style: TextStyle(fontSize: width*0.04,fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Text(pharmacy.pharmacyDescription.toString(),style: TextStyle(fontSize: width*0.03,)),
                    ],
                  ),
                );
              } else {
                return const Center(child: Text("Pharmacy data not found"));
              }
            } else if (state is LoadingPharmacyDetailsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ErrorPharmacyDetailsState) {
              return const Center(child: Text("Error loading pharmacy details"));
            } else {
              return const Center(child: Text("No data"));
            }
          },
          listener: (context, state) {
            const Text("Loading");
          },
        ));
  }
}


