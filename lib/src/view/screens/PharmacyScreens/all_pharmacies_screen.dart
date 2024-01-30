import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/all_holding_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/cubits/all_pharmacies_cubit.dart';
import 'package:pharmaease/src/controller/services/pharmacy_service.dart';
import 'package:pharmaease/src/controller/states/all_holding_pharmacies_state.dart';
import 'package:pharmaease/src/controller/states/all_pharmacies_state.dart';
import 'package:pharmaease/src/view/screens/PharmacyScreens/pharmacy_details_screen.dart';
import 'package:pharmaease/src/view/theme/colors.dart';

import '../HomePage/map_page.dart';

class AllPharmaciesScreen extends StatefulWidget {
  final String? drugName;

  AllPharmaciesScreen({Key? key, this.drugName}) : super(key: key);

  @override
  State<AllPharmaciesScreen> createState() => _AllPharmaciesScreenState();
}

class _AllPharmaciesScreenState extends State<AllPharmaciesScreen> {
  final PharmacyService _pharmacyService = PharmacyService();

  @override
  void initState() {
    super.initState();
    if (widget.drugName != null) {
      context
          .read<AllHoldingPharmaciesCubit>()
          .getBarcodeOrDrugName(null, BuiltList([widget.drugName]));
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if(widget.drugName==null) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("All pharmacies near you"),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black26,
          ),
          elevation: 0,
        ),
        body: BlocConsumer<AllPharmaciesCubit, AllPharmaciesState>(
            builder: (context, state) {
              AllPharmaciesCubit cubit = context.read<AllPharmaciesCubit>();
              return ListView.builder(
                  itemCount: cubit.pharmacies.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PharmacyDetailsScreen(
                              showHomeIcon: true,
                              pharmacyName:
                              cubit.pharmacies[index].pharmacyName.toString(),
                            ),
                          ),
                        );
                      },
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 15.0, left: 8, right: 8, bottom: 8),
                          child: Card(
                            color: Colors.white,
                            surfaceTintColor: Colors.white,
                            shadowColor: Colors.black87,
                            margin: EdgeInsets.all(3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 15),
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: NetworkImage(cubit
                                            .pharmacies[index].pharmacyImage
                                            .toString()),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 25.0),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(left: 8.0),
                                            child: Text(
                                              cubit.pharmacies[index].pharmacyName
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: screenWidth * 0.05,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                cubit.pharmacies[index].pharmacyArea
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(left: 8.0, bottom: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                        const Padding(
                                            padding: EdgeInsets.only(top: 4.0),
                                            child: Text(
                                              'Working Hours',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 4.0, left: 0),
                                            child: Text(
                                              formatHours(
                                                  DateTime.parse(cubit
                                                      .pharmacies[index]
                                                      .pharmacyOpeningHours
                                                      .toString()),
                                                  DateTime.parse(cubit
                                                      .pharmacies[index]
                                                      .pharmacyClosingHours
                                                      .toString())),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: screenWidth*0.1,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            _pharmacyService.launchPhone(
                                                cubit.pharmacies[index]
                                                    .pharmacyPhoneNumber
                                                    .toString());
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.phone,
                                                color: pharmaGreenColor,
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.02,
                                              ),
                                              Text(
                                                "Call",
                                                style: TextStyle(
                                                    fontSize: screenWidth * 0.03,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: screenWidth*0.08,),
                                        GestureDetector(
                                          onTap: () {
                                            if (cubit.pharmacies[index].location !=
                                                null) {
                                              _pharmacyService.launchGoogleMaps(
                                                  double.parse(cubit
                                                      .pharmacies[index]
                                                      .location
                                                      .latitude
                                                      .toString()),
                                                  double.parse(cubit
                                                      .pharmacies[index]
                                                      .location
                                                      .longitude
                                                      .toString()));
                                            }
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.pin_drop,
                                                color: pharmaGreenColor,
                                              ),
                                              SizedBox(
                                                width: screenWidth * 0.01,
                                              ),
                                              Text(
                                                "Directions",
                                                style: TextStyle(
                                                    fontSize: screenWidth * 0.03,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            },
            listener: (context, state) {
              const Text("Loading");
            }));}
    else{
      return Scaffold(
          appBar: AppBar(
            title: Text("Pharmacies holding ${widget.drugName}",maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.black26,
            ),
            elevation: 0,
          ),
          body: BlocConsumer<AllHoldingPharmaciesCubit, AllHoldingPharmaciesState>(
              builder: (context, state) {
                if(state is LoadedAllHoldingPharmaciesState){
                return ListView.builder(
                    itemCount: state.pharmacies.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PharmacyDetailsScreen(
                                showHomeIcon: false,
                                pharmacyName:
                                state.pharmacies[index].pharmacyName.toString(),
                                searchedDrug: widget.drugName,
                              ),
                            ),
                          );
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 8, right: 8, bottom: 8),
                            child: Card(
                              color: Colors.white,
                              surfaceTintColor: Colors.white,
                              shadowColor: Colors.black87,
                              margin: EdgeInsets.all(3),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 15),
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: NetworkImage(state
                                              .pharmacies[index].pharmacyImage
                                              .toString()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(left: 8.0),
                                              child: Text(
                                                state.pharmacies[index].pharmacyName
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: screenWidth * 0.05,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.pharmacies[index].pharmacyArea
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 13,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets.only(left: 8.0, bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding: EdgeInsets.only(top: 4.0),
                                              child: Text(
                                                'Working Hours',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, left: 0),
                                              child: Text(
                                                formatHours(
                                                    DateTime.parse(state
                                                        .pharmacies[index]
                                                        .pharmacyOpeningHours
                                                        .toString()),
                                                    DateTime.parse(state
                                                        .pharmacies[index]
                                                        .pharmacyClosingHours
                                                        .toString())),
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: screenWidth*0.1,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              _pharmacyService.launchPhone(
                                                  state.pharmacies[index]
                                                      .pharmacyPhoneNumber
                                                      .toString());
                                            },
                                            child: Row(
                                              children: [
                                               const Icon(
                                                  Icons.phone,
                                                  color: pharmaGreenColor,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.02,
                                                ),
                                                Text(
                                                  "Call",
                                                  style: TextStyle(
                                                      fontSize: screenWidth * 0.03,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: screenWidth*0.08,),
                                          GestureDetector(
                                            onTap: () {
                                              if (state.pharmacies[index].location != null) {
                                                _pharmacyService.launchGoogleMaps(
                                                    double.parse(state
                                                        .pharmacies[index]
                                                        .location
                                                        .latitude
                                                        .toString()),
                                                    double.parse(state
                                                        .pharmacies[index]
                                                        .location
                                                        .longitude
                                                        .toString()));
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.pin_drop,
                                                  color: pharmaGreenColor,
                                                ),
                                                SizedBox(
                                                  width: screenWidth * 0.01,
                                                ),
                                                Text(
                                                  "Directions",
                                                  style: TextStyle(
                                                      fontSize: screenWidth * 0.03,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });}
                else if(state is LoadingAllHoldingPharmaciesState){
                  return const Center(child: CircularProgressIndicator());
                }
                else{
                  return  const Text("No data");
                }
              },
              listener: (context, state) {
                const Text("Loading");
              }));}
    }
  }

  String formatHours(DateTime openingTime, DateTime closingTime) {
    String formattedOpeningTime = openingTime.hour > 12
        ? '${openingTime.hour - 12}PM'
        : '${openingTime.hour}AM';
    String formattedClosingTime = closingTime.hour > 12
        ? '${closingTime.hour - 12}PM'
        : '${closingTime.hour}AM';
    return '$formattedOpeningTime - $formattedClosingTime';
  }