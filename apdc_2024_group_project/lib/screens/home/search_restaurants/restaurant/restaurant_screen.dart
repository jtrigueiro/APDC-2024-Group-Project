import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/reserve_screen.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_info.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_menu.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/widgets.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant info;

  const RestaurantScreen({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final currentHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RestaurantInfo(info: info),
            Row(
              children: [
                Expanded(
                    child:
                        Divider(color: Theme.of(context).colorScheme.primary)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(
                    "Menu",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child:
                        Divider(color: Theme.of(context).colorScheme.primary)),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 50),
              child: RestaurantMenu(info: info),
            ),


            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReserveScreen(restaurant: info)));
              },
              child: const Text("Reserve"),
            ),
          ],
        ),
      ),
    );
  }
}
