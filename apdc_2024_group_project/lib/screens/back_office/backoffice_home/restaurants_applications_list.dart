import 'package:adc_group_project/screens/back_office/backoffice_home/restaurant_application_tile.dart';
import 'package:adc_group_project/services/models/restaurant_application.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsApplicationsList extends StatefulWidget {
  const RestaurantsApplicationsList({super.key});

  @override
  State<RestaurantsApplicationsList> createState() =>
      _RestaurantsApplicationsListState();
}

class _RestaurantsApplicationsListState
    extends State<RestaurantsApplicationsList> {
  @override
  Widget build(BuildContext context) {
    final restaurantsApplications =
        Provider.of<List<RestaurantApplication>?>(context) ?? [];

    return ListView.builder(
        itemCount: restaurantsApplications.length,
        itemBuilder: (context, index) {
          return RestaurantApplicationTile(
              restaurantApplication: restaurantsApplications[index]);
        });
  }
}
