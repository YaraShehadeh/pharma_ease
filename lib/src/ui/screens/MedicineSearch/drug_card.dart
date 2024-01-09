import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/drug_details_cubit.dart';
import 'package:pharmaease/src/controller/searched_drug_cubit.dart';
import 'package:pharmaease/src/ui/screens/drug_details_screen.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class DrugCard extends StatefulWidget {
  List<Drug>? drugs;
   DrugCard({super.key,required this.drugs});

  @override
  State<DrugCard> createState() => _DrugState();
}

class _DrugState extends State<DrugCard> {

  @override
  void initState(){
    super.initState();
    Future.delayed(Duration.zero,(){
      context.read<SearchedDrugCubit>().getSearchedDrug("panadol");
    });

  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;


            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: widget.drugs?.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                    child: Card(
                      color: Colors.white,
                      margin: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DrugDetailsScreen(drugName: "panadol")

                              )
                          );
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Expanded(
                                //   child: NetworkImage(
                                //     cubit.drugs![index].drugImage.toString(),
                                //     fit: BoxFit.cover,
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.drugs![index].drugName.toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('{widget.medicine.perscription}'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.local_pharmacy_outlined,
                                        color: pharmaGreenColor,
                                      ),
                                      Text(
                                        '${widget.drugs![index].holdingPharmacies
                                            .toString()} pharmacies near you',
                                        style: const TextStyle(fontSize: 10),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // if (widget.medicine.drugIsConflicting)
                            //   const Padding(
                            //     padding: EdgeInsets.all(8.0),
                            //     child: Icon(
                            //       Icons.warning_amber_rounded,
                            //       color: Colors.red,
                            //     ),
                            //   ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            );
  }
  }
