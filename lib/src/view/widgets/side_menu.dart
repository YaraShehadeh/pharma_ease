import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pharmaease/src/controller/cubits/authentication_cubit.dart';
import 'package:pharmaease/src/controller/states/authentication_state.dart';
import 'package:pharmaease/src/view/screens/DrugSearch/drugs_list_screen.dart';
import 'package:pharmaease/src/view/theme/colors.dart';
import 'package:pharmaease/src/view/screens/OnboardingPages/onboarding_screen.dart';
import 'package:pharmaease/src/view/screens/SignIn/sign_in_screen.dart';
import 'package:pharmaease/src/view/widgets/sign_out_pop_up.dart';

class SideMenu extends StatelessWidget {
  final bool showSearchDrug;

  SideMenu({super.key, required this.showSearchDrug});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final authCubit = context.read<AuthenticationCubit>().getToken();
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
                    padding:
                        const EdgeInsetsDirectional.only(top: 30, start: 13),
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
                          const Padding(
                            padding: EdgeInsets.only(bottom: 7.0),
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
                  const ListTile(
                    leading:
                        Icon(Icons.search, size: 28, color: Colors.white70),
                    minLeadingWidth: 3,
                    title: Text(
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
                  leading: Icon(Icons.message_outlined,
                      size: 28, color: Colors.white70),
                  minLeadingWidth: 3,
                  title: Text(
                    'ChatBot',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                if (state is AuthenticatedState)
                  ListTile(
                    leading: const Icon(Icons.logout,
                        size: 28, color: Colors.white70),
                    minLeadingWidth: 3,
                    title: const Text(
                      'Sign out',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return SignOutPopUp();
                          });
                      context.read<AuthenticationCubit>().expireSession();
                    },
                  ),
                if (state is UnauthenticatedState)
                  ListTile(
                    leading: const Icon(Icons.person,
                        size: 28, color: Colors.white70),
                    minLeadingWidth: 3,
                    title: const Text(
                      'Sign in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
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
      },
      listener: (BuildContext context, AuthenticationState state) {},
    );
  }
}
