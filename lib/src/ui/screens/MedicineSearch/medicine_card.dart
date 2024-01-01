// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pharmaease/src/controller/medicine_card_cubit.dart';
// import 'package:pharmaease/src/ui/screens/medicine_details_screen.dart';
// import 'package:pharmaease/src/ui/theme/colors.dart';
//
// class MedicineCard extends StatefulWidget {
//   const MedicineCard({super.key});
//
//   @override
//   State<MedicineCard> createState() => _DrugState();
// }
//
// class _DrugState extends State<MedicineCard> {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     return BlocBuilder<DrugCubit, DrugState>(
//         builder: (context, state) {
//           DrugCubit cubit = context.read<DrugCubit>();
//           return GridView.builder(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//               ),
//             itemCount: cubit.drugs.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
//                 child: Card(
//                   color: Colors.white,
//                   margin: const EdgeInsets.all(8.0),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => MedicineDetailsScreen()
//                           )
//                       );
//                     },
//                     child: Stack(
//                       alignment: Alignment.topRight,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Expanded(
//                               child: NetworkImage(
//                                 cubit.drugs.drugImage.toString(),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 cubit.drugs.drugName.toString(),
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                               child: Text('{widget.medicine.perscription}'),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.local_pharmacy_outlined,
//                                     color: pharmaGreenColor,
//                                   ),
//                                   Text(
//                                     '${cubit.drugs.holdingPharmacies
//                                         .toString()} pharmacies near you',
//                                     style: const TextStyle(fontSize: 10),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                         // if (widget.medicine.drugIsConflicting)
//                         //   const Padding(
//                         //     padding: EdgeInsets.all(8.0),
//                         //     child: Icon(
//                         //       Icons.warning_amber_rounded,
//                         //       color: Colors.red,
//                         //     ),
//                         //   ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//           );
//         }
//     );
//   }
//   }
