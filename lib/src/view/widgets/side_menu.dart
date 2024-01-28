import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/cubits/authentication_cubit.dart';
import 'package:pharmaease/src/controller/states/authentication_state.dart';
import 'package:pharmaease/src/view/screens/DrugSearch/drugs_list_screen.dart';
import 'package:pharmaease/src/view/screens/chatbot_screen.dart';
import 'package:pharmaease/src/view/screens/help_screen.dart';
import 'package:pharmaease/src/view/theme/colors.dart';
import 'package:pharmaease/src/view/screens/SignIn/sign_in_screen.dart';
import 'package:pharmaease/src/view/widgets/sign_out_pop_up.dart';

class SideMenu extends StatelessWidget {
  final bool showSearchDrug;

  const SideMenu({super.key, required this.showSearchDrug});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      builder: (context, state) {
        final authCubit = context.read<AuthenticationCubit>().getToken();
        return Drawer(
          child: Container(
            color: pharmaGreenColor,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.18,
                  child: DrawerHeader(
                    padding:
                        const EdgeInsetsDirectional.only(top: 30, start: 13),
                    decoration: const BoxDecoration(
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
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DrugsListScreen(fromMapPage: true,)),
                      );
                    },
                  ),
                ListTile(
                  leading: const Icon(Icons.message_outlined, size: 28, color: Colors.white70),
                  minLeadingWidth: 3,
                  title: const Text(
                    'ChatBot',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const ChatBotScreen()));
                  },
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
                          builder: (context) => const SignInScreen(),
                        ),
                      );
                    },
                  ),
                SizedBox(
                  height:screenHeight*0.5 ,
                ),
                ListTile(
                  leading:
                  const Icon(Icons.help_outline, size: 28, color: Colors.white70),
                  minLeadingWidth: 3,
                  title: const Text(
                    'Help',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                  onTap: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const HelpScreen()));
                  },
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
