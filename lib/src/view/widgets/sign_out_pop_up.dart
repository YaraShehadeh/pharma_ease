import 'package:flutter/material.dart';
import 'package:pharmaease/src/view/screens/HomePage/map_page.dart';

class SignOutPopUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 280,
        width: 100,
        child: Column(
          children: [
            const SizedBox(height: 15),
            Image.asset("assets/images/Done.png"),
            const SizedBox(height: 15),
            const Text(
              "Success",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            const Text(
              "You have signed out successfully",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const MapPage()), // Replace 'SearchMedicineScreen' with the actual class for your search medicine screen
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(25, 154, 142, 100),
                  fixedSize: const Size(500, 40)),
              child: const Text("Ok", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
