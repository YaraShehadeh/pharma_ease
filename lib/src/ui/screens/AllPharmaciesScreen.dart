import 'package:flutter/material.dart';
import 'package:pharmaease/src/model/pharmacy_details_model.dart';
import 'package:pharmaease/src/ui/screens/pharmacy_details_screen.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HomePage/map_page.dart';

class AllPharmaciesScreen extends StatefulWidget {
  static const String routeName='/all_pharmacies';
  const AllPharmaciesScreen({Key? key}) : super(key: key);

  @override
  State<AllPharmaciesScreen> createState() => _AllPharmaciesScreenState();
}

class _AllPharmaciesScreenState extends State<AllPharmaciesScreen> {
  final List<PharmacyDetailsModel> pharmacies = [
    PharmacyDetailsModel(
      pharmacyId: '1',
      pharmacyName: 'Pharmacy A',
      pharmacyEmail: 'pharmacyA@example.com',
      pharmacyDescription: 'Providing quality healthcare services.',
      pharmacyImage: 'assets/images/aster.png',
      pharmacyArea: 'Amman,Jubaiha',
      pharmacyDistance: '1.5',
      pharmacyOpeningHours: DateTime(2023, 1, 1, 8, 0),
      pharmacyClosingHours: DateTime(2023, 1, 1, 18, 0),
      pharmacyPhoneNumber: '0779593314'
    ),
    PharmacyDetailsModel(
      pharmacyId: '2',
      pharmacyName: 'Pharmacy B',
      pharmacyEmail: 'pharmacyB@example.com',
      pharmacyDescription: 'Your trusted neighborhood pharmacy.',
      pharmacyImage: 'assets/images/aster.png',
      pharmacyArea: 'Amman,Khalda',
      pharmacyDistance: '2.2',
      pharmacyOpeningHours: DateTime(2023, 1, 1, 6, 0),
      pharmacyClosingHours: DateTime(2023, 1, 1, 22, 0),
        pharmacyPhoneNumber: '0779593314'
    ),
    PharmacyDetailsModel(
      pharmacyId: '2',
      pharmacyName: 'Pharmacy B',
      pharmacyEmail: 'pharmacyB@example.com',
      pharmacyDescription: 'Your trusted neighborhood pharmacy.',
      pharmacyImage: 'assets/images/aster.png',
      pharmacyArea: 'Amman,Khalda',
      pharmacyDistance: '2.2',
      pharmacyOpeningHours: DateTime(2023, 1, 1, 6, 0),
      pharmacyClosingHours: DateTime(2023, 1, 1, 22, 0),
        pharmacyPhoneNumber: '0779593314'
    ),
    PharmacyDetailsModel(
      pharmacyId: '2',
      pharmacyName: 'Pharmacy B',
      pharmacyEmail: 'pharmacyB@example.com',
      pharmacyDescription: 'Your trusted neighborhood pharmacy.',
      pharmacyImage: 'assets/images/aster.png',
      pharmacyArea: 'Amman,Khalda',
      pharmacyDistance: '2.2',
      pharmacyOpeningHours: DateTime(2023, 1, 1, 6, 0),
      pharmacyClosingHours: DateTime(2023, 1, 1, 22, 0),
        pharmacyPhoneNumber: '0779593314'
    ),
    PharmacyDetailsModel(
      pharmacyId: '2',
      pharmacyName: 'Pharmacy B',
      pharmacyEmail: 'pharmacyB@example.com',
      pharmacyDescription: 'Your trusted neighborhood pharmacy.',
      pharmacyImage: 'assets/images/aster.png',
      pharmacyArea: 'Amman,Khalda',
      pharmacyDistance: '2.2',
      pharmacyOpeningHours: DateTime(2023, 1, 1, 6, 0),
      pharmacyClosingHours: DateTime(2023, 1, 1, 22, 0),
        pharmacyPhoneNumber: '0779593314'
    ),
    // Add more pharmacies as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("All pharmacies near you"),
         backgroundColor: Colors.white,
         leading: IconButton(
           icon: const Icon(Icons.arrow_back_ios),
           onPressed: () {
             Navigator.pushReplacement(
               context,
               MaterialPageRoute(builder: (context) => const MapPage()),
             );
           },
           color: Colors.black26,
         ),

         elevation: 0,
       ),
        body: ListView.builder(
            itemCount: pharmacies.length,
            itemBuilder: (context, index) {
              return PharmacyCard(pharmacy: pharmacies[index]);
            }));
  }
}

class PharmacyCard extends StatelessWidget {
  final PharmacyDetailsModel pharmacy;

   PharmacyCard({Key? key, required this.pharmacy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: (){
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  PharmacyDetailsScreen(showHomeIcon: true,),


          ),
        );
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:15.0,left: 8,right: 8,bottom: 8),
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
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: AssetImage(
                          'assets/images/aster.png',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 25.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              pharmacy.pharmacyName,
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                pharmacy.pharmacyArea,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 13,
                                    color: Colors.grey),
                              ),
                              Text(
                                '${pharmacy.pharmacyDistance}KM away',
                                style: TextStyle(
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
                      padding: const EdgeInsets.only(left: 15.0, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              'Working Hours',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0, left: 3),
                            child: Text(
                              formatHours(pharmacy.pharmacyOpeningHours,
                                  pharmacy.pharmacyClosingHours),
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 56),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: screenHeight * 0.09,
                                height: screenWidth * 0.09,
                                child:
                                    GestureDetector(
                                      onTap: (){
                                        _launchPhone(pharmacy.pharmacyPhoneNumber);
                                      },
                                      child:  Row(
                                        children: [Icon(
                                        Icons.phone,
                                        color: pharmaGreenColor,
                                      ),
                                        SizedBox(
                                          width: screenWidth * 0.02,
                                        ),
                                        Text(
                                          "Call",
                                          style: TextStyle(
                                              fontSize: screenWidth * 0.02,
                                              fontWeight: FontWeight.w500),
                                        ), ],
                                    ),


                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                width: screenHeight * 0.09,
                                height: screenWidth * 0.09,
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
                                          fontSize: screenWidth * 0.02,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            // onTap: (){
            //   Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder: (context) => PharmacyDetailsScreen()));
            // },
          ),
        ),
      ),
    );
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

void _launchPhone(String phoneNumber)async{
  final Uri phoneUri = Uri(scheme: 'tel',path: phoneNumber);
  final String url=phoneUri.toString();
  if(await canLaunchUrl(phoneUri)){
    await launchUrl(phoneUri);
  }
  else{
    throw 'could not launch $url';
  }
}
