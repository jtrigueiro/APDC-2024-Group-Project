import 'package:adc_group_project/screens/home/search_restaurants/search_restaurants_screen.dart';
import 'package:flutter/material.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/searchbar.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/top_carousel.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/middle_carousel.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<String> topCarouselImages = [
    'assets/images/italian.png',
    'assets/images/burger.png',
    'assets/images/traditional.png',
    'assets/images/sushi.png',
  ];

  // TODO - replace this with actual data
  final List<Map<String, String>> middleCarouselItems = [
      {
        'image': 'assets/images/restaurant1.png',
        'name': 'Restaurante Verde',
        'location': 'Almada',
        'menu': 'name: "Bife à Portuguesa", price: 10.0, description: "Bife com batatas fritas e ovo estrelado"',
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
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          children: [
            const SizedBox(height: 20.0),
            SearchButton(onPressed: () => _onSearchPressed(context)),
            TopCarousel(images: topCarouselImages),
            MiddleCarousel(items: middleCarouselItems),
          ],
        );
      },
    );
  }
}

// isto é usado?
extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
