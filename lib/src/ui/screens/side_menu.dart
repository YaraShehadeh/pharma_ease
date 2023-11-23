import 'package:flutter/material.dart';
import 'package:pharmaease/src/ui/screens/medicine%20search/search_medicine_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF199A8E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // height: 120,
            SizedBox(
              height: 140,
              child: DrawerHeader(
                padding: const EdgeInsetsDirectional.only(top: 30, start: 13),
                decoration: const BoxDecoration(
                  color: Color(0xFF199A8E),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PharmaEase',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Helping you every step of the way",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white60,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const Divider(
            //   color: Colors.white,
            // ),
            const ListTile(
              leading: Icon(Icons.home, size: 28, color: Colors.white70),
              minLeadingWidth: 3,
              title: Text(
                'Home',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            ListTile(
              leading: Icon(Icons.search, size: 28, color: Colors.white70),
              minLeadingWidth: 3,
              title: const Text(
                'Search Drug',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MedicineListScreen()), // Replace 'SearchMedicineScreen' with the actual class for your search medicine screen
                );
              },
            ),

            const ListTile(
              leading:
                  Icon(Icons.message_outlined, size: 28, color: Colors.white70),
              minLeadingWidth: 3,
              title: Text(
                'ChatBot',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const ListTile(
              leading:
                  Icon(Icons.message_outlined, size: 28, color: Colors.white70),
              minLeadingWidth: 3,
              title: Text(
                'Request Restock',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.person, size: 28, color: Colors.white70),
              minLeadingWidth: 3,
              title: Text(
                'Sign in',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
              // ADD ROUTING TO SIGN IN PAGE
              // onTap: Navigator.pushReplacement(context, OnBoardingScreen()),
            ),
            const SizedBox(
              height: 290,
            ),
            const ListTile(
              leading:
                  Icon(Icons.help_outline, size: 28, color: Colors.white70),
              minLeadingWidth: 3,
              title: Text(
                'Help',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
      ),
    );
  }
}