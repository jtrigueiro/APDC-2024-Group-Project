import 'package:adc_group_project/screens/back_office/restaurant_types/add_restaurats_types';
import 'package:adc_group_project/screens/back_office/restaurant_types/list_restaurants_types';
import 'package:flutter/material.dart';

class RestaurantTypesManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Types Management'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddRestaurantTypePage()),
                );
              },
              child: Text('Add Restaurant Type'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListRestaurantTypesPage()),
                );
              },
              child: Text('List Restaurant Types'),
            ),
          ],
        ),
      ),
    );
  }
}
