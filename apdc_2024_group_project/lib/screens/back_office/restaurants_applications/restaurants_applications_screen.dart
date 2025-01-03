import 'package:adc_group_project/screens/back_office/restaurants_applications/restaurants_applications_list.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';
import 'package:flutter/material.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:provider/provider.dart';

class RestaurantsApplicationsScreen extends StatelessWidget {
  const RestaurantsApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<RestaurantApplication>?>.value(
      initialData: null,
      value: DatabaseService().restaurantsApplications,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Requests'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: RestaurantsApplicationsList(),
      ),
    );
  }
}
