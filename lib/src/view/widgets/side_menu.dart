import 'package:flutter/material.dart';
import 'package:pharmaease/src/view/screens/MedicineSearch/drugs_list_screen.dart';
import 'package:pharmaease/src/view/theme/colors.dart';
import 'package:pharmaease/src/view/screens/onboarding_screen.dart';
import 'package:pharmaease/src/view/screens/sign_in_screen.dart';

class SideMenu extends StatelessWidget {
  final bool showSearchDrug;
  const SideMenu({super.key,required this.showSearchDrug});


  @override
  Widget build(BuildContext context) {
      return Drawer(
      child: Container(
        color: pharmaGreenColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // height: 120,
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              child: DrawerHeader(
                padding: const EdgeInsetsDirectional.only(top: 30, start: 13),
                decoration: BoxDecoration(
                  color: pharmaGreenColor,
                ),
                child: Flexible(
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
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7.0),
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
            ),
            if (showSearchDrug)
              ListTile(
                leading:
                    const Icon(Icons.search, size: 28, color: Colors.white70),
                minLeadingWidth: 3,
                title: const Text(
                  'Search Drug',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400),
                ),
                // onTap: () {
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //         DrugsListScreen()), // Replace 'SearchMedicineScreen' with the actual class for your search medicine screen
                //   );
                // },
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
             ListTile(
              leading: const Icon(Icons.person, size: 28, color: Colors.white70),
              minLeadingWidth: 3,
              title: const Text(
                'Sign in',
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
                      SignInScreen()), // Replace 'SearchMedicineScreen' with the actual class for your search medicine screen
                );
              },
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
