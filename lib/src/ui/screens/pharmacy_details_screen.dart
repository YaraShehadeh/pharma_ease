import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';

class PharmacyDetailsScreen extends StatefulWidget {
  const PharmacyDetailsScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PharmacyDetailsScreenState();
}

class _PharmacyDetailsScreenState extends State<PharmacyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () {},
            color: const Color.fromRGBO(25, 154, 142, 100),
            iconSize: 30,
          ),
        ],
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const Text("Aster Pharmacy",
                  style: TextStyle(
                    fontSize: 30,
                  )),
              const SizedBox(height: 30),
              const Image(
                image: AssetImage('assets/images/aster.png'),
              ),
              Row(children: [
                const SizedBox(
                  width: 30,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.location_on_outlined),
                ),
                const Text("500m from you"),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.access_time_outlined)),
                const Text("2 mins away"),
              ]),
              Row(
                children: [
                  const SizedBox(
                    width: 80,
                  ),
                  const Image(
                      image: AssetImage('assets/images/diections-icon.jpeg')),
                  const Text("Directions"),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call_outlined),
                  ),
                  const Text("Call"),
                ],
              ),
              const Divider(
                thickness: 0.6,
                color: Colors.black,
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.location_on),
                    onPressed: () {},
                    color: const Color.fromRGBO(25, 154, 142, 100),
                    iconSize: 30,
                  ),
                  const Text(
                    "Address",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const Text("Amman, example st"),
              const Divider(thickness: 0.6, color: Colors.black),
              const Text("Description"),
            ],
          )),
    );
  }
}
