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
              label: 'Carbon Footprint',
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
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Color.fromARGB(255, 201, 201, 201),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
