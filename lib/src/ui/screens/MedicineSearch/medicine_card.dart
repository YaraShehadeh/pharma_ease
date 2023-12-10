// import 'package:flutter/material.dart';
// import 'package:pharmaease/src/model/medicine_model.dart';
// import 'package:pharmaease/src/ui/screens/medicine_details_screen.dart';
// import 'package:pharmaease/src/ui/theme/colors.dart';
//
// class MedicineCard extends StatefulWidget {
//   final DrugModel medicine;
//
//   const MedicineCard({super.key, required this.medicine});
//
//   @override
//   State<MedicineCard> createState() => _MedicineCardState();
// }
//
// class _MedicineCardState extends State<MedicineCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
//       child: Card(
//         color: Colors.white,
//         margin: const EdgeInsets.all(8.0),
//         child: InkWell(
//           onTap: () {
//             Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => MedicineDetailsScreen(
//                           medicine: DrugModel(
//                             drugID: 1,
//                             drugName: 'Paracetamol',
//                             drugDescription:
//                                 "OBH COMBI is a cough medicine containing, Paracetamol, Ephedrine HCl, and Chlorphenamine maleate which is used to relieve coughs accompanied by flu symptoms such as fever, headache, and sneezing.",
//                             drugPerscription: "3pcs",
//                             holdingPharmacies: 4,
//                             drugIsConflicting: true,
//                             drugImages: [
//                               'assets/images/onboarding_image_1.png'
//                             ],
//                           ),
//                         )));
//           },
//           child: Stack(
//             alignment: Alignment.topRight,
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Expanded(
//                     child: Image.asset(
//                       widget.medicine.drugImages[0],
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       widget.medicine.drugName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text('{widget.medicine.perscription}'),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.local_pharmacy_outlined,
//                           color: pharmaGreenColor,
//                         ),
//                         Text(
//                           '${widget.medicine.holdingPharmacies.toStringAsFixed(0)} pharmacies near you',
//                           style: const TextStyle(fontSize: 10),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               if (widget.medicine.drugIsConflicting)
//                 const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Icon(
//                     Icons.warning_amber_rounded,
//                     color: Colors.red,
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
