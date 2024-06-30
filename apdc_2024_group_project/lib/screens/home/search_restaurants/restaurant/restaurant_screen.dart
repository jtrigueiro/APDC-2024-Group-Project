import 'package:adc_group_project/screens/home/search_restaurants/restaurant/reserve_screen.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_info.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_menu.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/material.dart';

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
          RestaurantInfo(info: info),
          //RestaurantMenu(info: info),
          Positioned(
            height: currentHeight * 0.05,
            width: MediaQuery.of(context).size.width,
            bottom: currentHeight * 0.05,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(52, 168, 83, 0.23),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReserveScreen(restaurant: info)));
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
