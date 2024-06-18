import 'package:adc_group_project/screens/back_office/restaurants_applications_screen.dart';
import 'package:flutter/material.dart';

class BackOfficeHomeScreen extends StatelessWidget {
  BackOfficeHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Office'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => RestaurantsApplicationsScreen(),
              ),
            );
          },
          child: Text('Restaurants Applications'),
        ),
      ),
    );
  }
}
