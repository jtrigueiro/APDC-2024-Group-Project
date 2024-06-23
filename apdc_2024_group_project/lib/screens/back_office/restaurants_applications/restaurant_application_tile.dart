import 'package:adc_group_project/services/database.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';
import 'package:flutter/material.dart';

class RestaurantApplicationTile extends StatelessWidget {
  const RestaurantApplicationTile(
      {super.key, required this.restaurantApplication});

  final RestaurantApplication restaurantApplication;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.cancel_outlined),
              onPressed: () {
                DatabaseService()
                    .deleteRestaurantApplication(restaurantApplication.uid);
              },
            ),
            Expanded(
              child: ListTile(
                //leading: const Icon(Icons.restaurant),
                title: Text(restaurantApplication.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Phone: ${restaurantApplication.phone}'),
                    Text('Location: ${restaurantApplication.location}'),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.check_circle_outlined),
              onPressed: () {
                DatabaseService().addOrUpdateRestaurantData(
                    restaurantApplication.uid,
                    restaurantApplication.name,
                    restaurantApplication.phone,
                    restaurantApplication.location);
                DatabaseService()
                    .deleteRestaurantApplication(restaurantApplication.uid);
              },
            ),
          ],
        ),
      ),
    );
  }
}
