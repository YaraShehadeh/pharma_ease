import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmaease/src/controller/alternative_drugs_cubit.dart';
import 'package:pharmaease/src/controller/searched_drug_cubit.dart';
import 'package:pharmaease/src/ui/screens/MedicineSearch/drug_card.dart';
import 'package:pharmaease/src/ui/screens/HomePage/map_page.dart';
import 'package:pharmaease/src/ui/widgets/search_bar_widget.dart';
import 'package:pharmaease/src/ui/widgets/side_menu.dart';
import 'package:pharmaease/src/ui/theme/colors.dart';
import 'package:pharmaease_api/pharmaease_api.dart';

class DrugsListScreen extends StatefulWidget {
  static const String routeName = '/medicine_list';
  bool fromMapPage=false;
  DrugsListScreen({super.key,required this.fromMapPage});

  @override
  State<DrugsListScreen> createState() => _DrugsListScreenState();
}

class _DrugsListScreenState extends State<DrugsListScreen>  with TickerProviderStateMixin{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  late final AnimationController _controller;
  bool hasSearched = false;
  int currentTabIndex=0;
  List<Drug>? drugs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    drugs=[];
    if(widget.fromMapPage ){
    context.read<SearchedDrugCubit>().emit(InitialSearchedDrugState());
    context.read<AlternativeDrugsCubit>().emit(InitialAlternativeDrugsState());}
    _controller= AnimationController(vsync: this)
      ..addStatusListener((status) {
        if(status == AnimationStatus.completed){
          _controller.repeat();
        }
      });
  }
  @override
  void dispose(){
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }
  void clearData(){
    setState(() {
      drugs=[];
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                setState(() {
                  drugs=[];
                });
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
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 150.0),
                  child: TabBarView(
                    controller: _tabController,
                    children:[
                      BlocConsumer<SearchedDrugCubit, SearchedDrugState>(
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
                      else if(state is IncorrectSearchedDrugState){
                        return Container(
                          height:40,
                          child:
                            Lottie.asset(
                               "assets/animations/no_drugs_found_animation.json",
                                controller:_controller,
                                onLoaded:(composition){
                                 _controller
                                     ..duration=composition.duration
                                     ..forward();
                                }
                              ),

                        );
                      }
                      return const Center(child:Text("No drugs searched"));
                    }, listener: (context, state) {
                      const Text("Loading");
                    }),
                      BlocConsumer<AlternativeDrugsCubit, AlternativeDrugsState>(
                          builder: (context, state) {
                            if (state is LoadingAlternativeDrugsState) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is LoadedAlternativeDrugsState) {
                              drugs=state.drugs;
                              return DrugCard( drugs: drugs,);
                            }
                            else if(state is ErrorAlternativeDrugsState){
                              return Text("No alternative drugs found");
                            }
                            else if(state is IncorrectAlternativeSearchedDrugState){
                              return Container(
                                height:40,
                                child:
                                Lottie.asset(
                                    "assets/animations/no_drugs_found_animation.json",
                                    controller:_controller,
                                    onLoaded:(composition){
                                      _controller
                                        ..duration=composition.duration
                                        ..forward();
                                    }
                                ),

                              );
                            }
                            return const Center(child:Text("No drugs searched"));
                          }, listener: (context, state) {
                        const Text("Loading");
                      }),


                    ] ),
                ),
                Padding(
                  padding: const EdgeInsets.all(70.0),
                  child: Material(
                    color:Colors.white,
                    child: TabBar(
                        controller: _tabController,
                        indicatorColor: pharmaGreenColor,
                        labelColor: pharmaGreenColor,
                        unselectedLabelColor: Colors.grey,
                        tabs: const [
                          Tab(
                            text: 'Drugs',
                          ),
                          Tab(
                            text: 'Alternatives',
                          )
                        ],
                        ),
                  ),
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
            );
          }
        ),
      ),
    );
  }
}
