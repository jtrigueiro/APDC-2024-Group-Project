import 'package:adc_group_project/screens/back_office/backoffice_home_screen.dart';
import 'package:adc_group_project/screens/carbon_footprint/carbon_footprint.dart';
import 'package:adc_group_project/screens/favorites/favorites_screen.dart';
import 'package:adc_group_project/screens/home/home_screen.dart';
import 'package:adc_group_project/screens/profile/profile_screen.dart';
import 'package:adc_group_project/screens/reservations/reservations_screen.dart';
import 'package:adc_group_project/screens/responsiveWidget.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomeRouter extends StatefulWidget {
  const HomeRouter({super.key});

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {
  int _currentIndex = 0;
  bool loading = true;
  bool isAdmin = false;

  final List _isHovering =[
    false,
    false,
    false,
    false,
    false,
  ];

  final texts = [
    const Text('Home'),
    const Text('Reservations'),
    const Text('CO2'),
    const Text('Favorite Restaurants'),
    const Text('Profile'),
  ];

  final screens = [
    const HomeScreen(),
    const ReservationsScreen(),
    CarbonFootprintScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  initState() {
    userisAdmin();
    super.initState();
  }

  userisAdmin() async {
    if (await DatabaseService().isAdmin()) {
      setState(() {
        isAdmin = true;
        loading = false;
      });
    } else {
      setState(() {
        isAdmin = false;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return web(context);
    } else {
      return app(context);
    }
  }

  web(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : isAdmin
            ? BackOfficeHomeScreen()
            : Scaffold(
                appBar: ResponsiveWidget.isSmallScreen(context) ||  ResponsiveWidget.isMediumScreen(context)
                    ? AppBar(
                        backgroundColor: Theme.of(context).colorScheme.background,
                        title: Text('EcoDine', style: Theme.of(context).textTheme.titleLarge,),
                      )
                    : PreferredSize(
                        preferredSize:
                            Size(MediaQuery.of(context).size.width, 70),
                        child: buildTopBar (),
                      ),
                drawer: appDrawer(),
                /*AppBar(
                        title: texts[_currentIndex],
                        bottom:TabBar(
                          tabs: const <Tab>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.book),
            ),
            Tab(
              icon: Icon(Icons.eco),
            ),
            Tab(
              icon: Icon(Icons.favorite),
            ),
            Tab(
              icon: Icon(Icons.person),
            ),
                          ],
                          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
                          },
                        ),
                      ),*/
                body: screens[_currentIndex],
                /* TabBarView(
                  children: [
                    const HomeScreen(),
                    const ReservationsScreen(),
                    CarbonFootprintScreen(),
                    FavoritesScreen(),
                    ProfileScreen(),
                  ],
                ),*/
              );
  }
  void changeScreen (int index)
  {
     setState(() {
      _currentIndex = index;
    });

  }

  Drawer appDrawer() {
    return Drawer(
      width: 200,
      elevation: 5,
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            drawerItems('Home', () {changeScreen(0);}),
             Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            drawerItems('Reservations', () {changeScreen(1);}),
             Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            drawerItems('CO2', () {changeScreen(2);}),
             Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

            drawerItems('Favorites', () {changeScreen(3);}),
             Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            drawerItems('Profile', () {changeScreen(4);}),
             Padding(
              padding: EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell drawerItems(String name, Function ontap) {
    return InkWell(
      onTap: () {ontap();},
      child: Text(
        name,
        style:  TextStyle(color: Theme.of(context).colorScheme.onBackground),
      ),
    );
  }

  app(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : isAdmin
            ? BackOfficeHomeScreen()
            : Scaffold(
                body: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: screens[_currentIndex],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.book),
                      label: 'Reservations',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.eco),
                      label: 'CO2',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Favorites',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              );
  }


  Widget buildTopBar ()
  {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      child: Padding(padding: EdgeInsets.all(20),
        child: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: screenSize.width/4),
              Text('EcoDine', style: Theme.of(context).textTheme.titleLarge,),
              SizedBox(width: screenSize.width/15,),
              buildTop('Home',0,() {changeScreen(0);}),
              SizedBox(width: screenSize.width/15,),
              buildTop('Reservation',1,() {changeScreen(1);}),
              SizedBox(width: screenSize.width/15,),
              buildTop('CO2',2,() {changeScreen(2);}),
              SizedBox(width: screenSize.width/15,),
              buildTop('Favorites',3,() {changeScreen(3);}),
              SizedBox(width: screenSize.width/15,),
              buildTop('Profile',4,() {changeScreen(4);})
            ],
          ) ,
        ),),
    );
  }

  InkWell buildTop (String name, int index, Function ontap)
  {
    return  InkWell(
      onHover: (value){
        setState(() {
          value ? _isHovering[index] = true
              : _isHovering[index] = false;
        });
      },
      onTap: () {ontap();},
      child: Column(
        children: [
          Text(name),
          const SizedBox(height: 5),
          Visibility( maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: _isHovering[index],
              child: Container(height: 2, color: Colors.black,width: 20,))
        ],
      ) ,
    );
  }
}


