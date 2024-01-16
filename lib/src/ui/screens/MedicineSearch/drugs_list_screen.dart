import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharmaease/src/controller/searched_drug_cubit.dart';
import 'package:pharmaease/src/ui/screens/MedicineSearch/drug_card.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/ui/widgets/search_bar_widget.dart';
import 'package:pharmaease/src/ui/widgets/side_menu.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class DrugsListScreen extends StatefulWidget {
  static const String routeName = '/medicine_list';

  DrugsListScreen({super.key});

  @override
  State<DrugsListScreen> createState() => _DrugsListScreenState();
}

class _DrugsListScreenState extends State<DrugsListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool hasSearched = false;
  List<Drug>? drugs;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.black,
          onPressed: () {
            if (_scaffoldKey.currentState != null) {
              _scaffoldKey.currentState!.openDrawer();
            }
          },
        ),
        title: const Text(
          '',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: pharmaGreenColor),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MapPage()));
            },
          ),
        ],
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      drawer: const Drawer(
        child: SideMenu(
          showSearchDrug: false,
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 60.0),
            child: BlocConsumer<SearchedDrugCubit, SearchedDrugState>(
                builder: (context, state) {
              if (state is LoadingSearchedDrugState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is LoadedSearchedDrugState) {
                  drugs=state.drugs;
                return DrugCard( drugs: drugs,);
              }
              else if(state is ErrorSearchedDrugState){
                return Text("Drug does not exist");
              }
              return const Center(child:Text("No drugs searched"));
            }, listener: (context, state) {
              const Text("Loading");
            }),
          ),
          const Positioned(
            left: 10,
            right: 10,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SearchBarWidget(
                isFromSearchDrugScreen: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
