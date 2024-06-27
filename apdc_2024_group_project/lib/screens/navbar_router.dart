import 'package:adc_group_project/screens/back_office/backoffice_home_screen.dart';
import 'package:adc_group_project/screens/carbon_footprint/carbon_footprint.dart';
import 'package:adc_group_project/screens/favorites/favorites_screen.dart';
import 'package:adc_group_project/screens/home/home_screen.dart';
import 'package:adc_group_project/screens/profile/profile_screen.dart';
import 'package:adc_group_project/screens/reservations/reservations_screen.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
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

  final screens = [
    HomeScreen(),
    ReservationsScreen(),
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
    return loading
        ? LoadingScreen()
        : (isAdmin
            ? BackOfficeHomeScreen()
            : Scaffold(
                body: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: screens[_currentIndex],
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      backgroundColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      icon: const Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      icon: const Icon(Icons.book),
                      label: 'Reservations',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      icon: const Icon(Icons.eco),
                      label: 'Carbon Footprint',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      icon: const Icon(Icons.favorite),
                      label: 'Favorites',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: Theme.of(context)
                          .bottomNavigationBarTheme
                          .backgroundColor,
                      icon: const Icon(Icons.person),
                      label: 'Profile',
                    ),
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ));
  }
}
