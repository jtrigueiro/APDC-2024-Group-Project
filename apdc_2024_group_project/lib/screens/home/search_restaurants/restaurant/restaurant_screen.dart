import 'package:flutter/material.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/reserve_screen.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_info.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_menu.dart';
import 'package:adc_group_project/services/models/restaurant.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant info;

  const RestaurantScreen({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                RestaurantInfo(info: info),
                RestaurantMenu(info: info),
                SizedBox(height: currentHeight * 0.1), // Space for the button
              ],
            ),
          ),
          Positioned(
            height: currentHeight * 0.07,
            width: MediaQuery.of(context).size.width,
            bottom: currentHeight * 0.02,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ReserveScreen(restaurant: info)));
                },
                child: const Text("Reserve"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
