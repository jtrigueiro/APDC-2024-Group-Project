import 'package:flutter/material.dart';
import 'package:adc_group_project/screens/home/objects/searchbar.dart';
import 'package:adc_group_project/screens/home/objects/top_carousel.dart';
import 'package:adc_group_project/screens/home/objects/middle_carousel.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> topCarouselImages = [
    'assets/images/italian.png',
    'assets/images/burger.png',
    'assets/images/traditional.png',
    'assets/images/sushi.png',
  ];
  final List<Map<String, String>> middleCarouselItems = [
    {
      'image': 'assets/images/restaurant1.png',
      'name': 'Restaurante Verde',
      'location': 'Almada'
    },
    {
      'image': 'assets/images/restaurant2.png',
      'name': 'Restaurante Vermelho',
      'location': 'Algueirão Mem Martins'
    },
    {
      'image': 'assets/images/restaurant3.png',
      'name': 'Restaurante Azul',
      'location': 'Lisboa'
    },
  ];

  void _onSearchPressed(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                  height: 20.0), // Espaçamento extra acima do botão de pesquisa
              SearchButton(onPressed: () => _onSearchPressed(context)),
              TopCarousel(images: topCarouselImages),
              MiddleCarousel(items: middleCarouselItems),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          // Handle bottom nav bar tap
        },
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
