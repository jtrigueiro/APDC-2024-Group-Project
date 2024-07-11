import 'package:flutter/material.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/reserve_screen.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_info.dart';
import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen_objects/restaurant_menu.dart';
import 'package:adc_group_project/services/models/restaurant.dart';

class RestaurantScreen extends StatelessWidget {
  final Restaurant info;
  final DateTime? day;

  const RestaurantScreen({super.key, required this.info, required this.day});

  DateTime getDay(DateTime? day) {
    if(day == null) {
      DateTime now = DateTime.now();
      DateTime firstDay = now;
      for (int i = 0; i < 7; i++) {
        DateTime currentDay = now.add(Duration(days: i));
        if (info.isOpen[currentDay.weekday - 1]) {
          firstDay = currentDay;
          break;
        }
      }
      return firstDay;
    }
    return day;
  }

  @override
  Widget build(BuildContext context) {
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


            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: ElevatedButton(
                onPressed: () {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ReserveScreen(restaurant: info, day: getDay(day))));
                },
                child: const Text("Reserve"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
