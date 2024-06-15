import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_info.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_menu.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  final Map<String, dynamic> info;

  const RestaurantScreen({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          RestaurantInfo(info: info),
          RestaurantMenu(info: info),
          Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              height: currentHeight * 0.05,
              width: double.infinity,
              color: const Color.fromRGBO(255, 255, 255, 0.23),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(52, 168, 83, 0.23),
                ),
                onPressed: () {
                  //reservation_screen.dart
                },
                child: const Text(" R E S E R V E"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
