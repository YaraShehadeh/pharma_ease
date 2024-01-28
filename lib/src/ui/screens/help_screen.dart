import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';

import 'HomePage/map_page.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Help',style: TextStyle(fontWeight: FontWeight.w700,color: pharmaGreenColor,fontSize: 30),)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MapPage()));
          },

          color: Colors.black26,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'How to Use the App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'Here you can provide detailed instructions or guidance on how to use the application. '
                    'Explain different features and functionalities, and provide any other relevant information '
                    'that can assist users in navigating and utilizing the app effectively.',
                style: TextStyle(fontSize: 16),
              ),
              // Add more Widgets here for additional help content
            ],
          ),
        ),
      ),
    );
  }
}