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
import 'package:flutter/widgets.dart';

class HomeRouter extends StatefulWidget {
  const HomeRouter({super.key});

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {
  int _currentIndex = 0;
  bool loading = true;
  bool isAdmin = false;

  final List _isHovering = [
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
                appBar: /*ResponsiveWidget.isSmallScreen(context) ||
                        ResponsiveWidget.isMediumScreen(context)
                    ? */AppBar(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        title: Text(
                          'EcoDine',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      )
                   /* : PreferredSize(
                        preferredSize:
                            Size(MediaQuery.of(context).size.width, 70),
                        child: buildTopBar(),
                      ),*/,
                drawer: appDrawer(),
                body: screens[_currentIndex],

              );
  }

  void changeScreen(int index) {
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
            drawerItems('Home',0, () {
              changeScreen(0);
            }),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            drawerItems('Reservations',1, () {
              changeScreen(1);
            }),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            drawerItems('CO2',2, () {
              changeScreen(2);
            }),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            drawerItems('Favorites', 3,() {
              changeScreen(3);
            }),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            drawerItems('Profile', 4, () {
              changeScreen(4);
            }),
            Padding(
              padding: const EdgeInsets.only(
                top: 5.0,
                bottom: 5,
              ),
              child: Divider(
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),

             Expanded(
              child: Align(alignment: Alignment.bottomCenter,
              child: Text('Copyright © | Ecodine by Dynamic Crew', style: Theme.of(context).textTheme.titleSmall,textAlign: TextAlign.center,),),
            )
          ],
        ),
      ),
    );
  }

  InkWell drawerItems(String name, int index, Function ontap) {
    return InkWell(
      onTap: () {
        ontap();
        Navigator.of(context).pop();
      },
      child: Text(
        name,
        style: _currentIndex == index
            ? Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)
            : Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
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

  Widget buildTopBar() {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.background , border: const Border(bottom: BorderSide(color: Colors.black12))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Expanded(
          child: Row(
            children: [
              SizedBox(width: screenSize.width / 10),
              Text(
                'EcoDine',
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(fontSize: 30),
              ),
              SizedBox(
                width: screenSize.width / 5,
              ),
              buildTop('Home', 0, () {
                changeScreen(0);
              }),
              SizedBox(
                width: screenSize.width / 30,
              ),
              const VerticalDivider(color: Colors.grey,
              endIndent: 10, indent: 10,),
              SizedBox(
                width: screenSize.width / 30,
              ),
              buildTop('Reservation', 1, () {
                changeScreen(1);
              }),
              SizedBox(
                width: screenSize.width / 30,
              ),
              const VerticalDivider(color: Colors.grey,endIndent: 10, indent: 10,),
              SizedBox(
                width: screenSize.width / 30,
              ),
              buildTop('CO2', 2, () {
                changeScreen(2);
              }),
              SizedBox(
                width: screenSize.width / 30,
              ),
              VerticalDivider(color:Colors.grey,endIndent: 10, indent: 10,),
              SizedBox(
                width: screenSize.width / 30,
              ),
              buildTop('Favorites', 3, () {
                changeScreen(3);
              }),
              SizedBox(
                width: screenSize.width / 30,
              ),
              VerticalDivider(color: Colors.grey,endIndent: 10, indent: 10,),
              SizedBox(
                width: screenSize.width / 30,
              ),
              buildTop('Profile', 4, () {
                changeScreen(4);
              })
            ],
          ),
        ),
      ),
    );
  }

  InkWell buildTop(String name, int index, Function ontap) {
    return InkWell(
      onHover: (value) {
        setState(() {
          value ? _isHovering[index] = true : _isHovering[index] = false;
        });
      },
      onTap: () {
        ontap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name,
              style: _currentIndex == index
                  ? Theme.of(context).textTheme.bodyMedium
                  : Theme.of(context).textTheme.titleSmall),
         const SizedBox(height: 5),
          Visibility(
              maintainAnimation: true,
              maintainState: true,
              maintainSize: true,
              visible: _isHovering[index] || _currentIndex == index,
              child: Container(
                height: 2,
                color: Theme.of(context).colorScheme.onBackground,
                width: 20,
              ))

        ],
      ),
    );
  }
}
