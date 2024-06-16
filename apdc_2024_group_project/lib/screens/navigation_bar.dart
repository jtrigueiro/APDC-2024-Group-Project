
import 'package:adc_group_project/screens/carbon_footprint/carbon_footprint.dart';
import 'package:adc_group_project/screens/favorites/favorites_screen.dart';
import 'package:adc_group_project/screens/home/home_screen.dart';
import 'package:adc_group_project/screens/profile/profile_screen.dart';
import 'package:adc_group_project/screens/reservations/reservations_screen.dart';
import 'package:flutter/material.dart';

class HomeRouter extends StatefulWidget {
  const HomeRouter({super.key});

  @override
  State<HomeRouter> createState() => _HomeRouterState();
}

class _HomeRouterState extends State<HomeRouter> {
  int _currentIndex = 0;

  final screens = [
    HomeScreen(),
    ReservationsScreen(),
    CarbonFootprintScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.book),
            label: 'Reservations',
          ),

          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.eco),
            label: 'Carbon Footprint',
          ),

          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),

          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
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
}
