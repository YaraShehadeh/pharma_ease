import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';


class MedicalInteractionsPopUP extends StatelessWidget {
  String interactions;
   MedicalInteractionsPopUP({Key?key,required this.interactions}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 280,
        width: 100,
        child: Column(
          children: [
            Row(children: [
              SizedBox(width: 200,),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: CircleAvatar(
                      radius: 14.0,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.close, color: pharmaGreenColor),
                    ),
                  ),
                ),

            ],),
            const SizedBox(height: 15),
            Icon(Icons.warning_amber_outlined,color: Colors.red,size: 50,),
            const SizedBox(height: 15),
            const Text(
              "Medical/Substance Interactions",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
             Text(interactions
              ,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            // ElevatedButton(
            //   onPressed: () {
            //     Navigator.pushReplacement(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) =>
            //          place 'SearchMedicineScreen' with the actual class for your search medicine screen
            //     );
            //   },
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
            //       fixedSize: const Size(500, 40)),
            //   child:
            //   const Text("Sign In", style: TextStyle(color: Colors.white)),
            // ),
          ],
        ),
      ),
    );
  }
}