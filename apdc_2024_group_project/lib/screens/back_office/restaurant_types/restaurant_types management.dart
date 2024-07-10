import 'package:adc_group_project/screens/back_office/restaurant_types/add_restaurats_types.dart';
import 'package:adc_group_project/screens/back_office/restaurant_types/list_restaurants_types.dart';
import 'package:flutter/material.dart';

class RestaurantTypesManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Types'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              workButton('Add Restaurant Type', ontapAddType(context)),
              workButton('List Restaurant Types', ontapListType(context)),
            ]),
      ),
    );
  }

  Function ontapAddType(context) {
    return () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddRestaurantTypePage(),
        ),
      );
    };
  }

  Function ontapListType(context) {
    return () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ListRestaurantTypesPage(),
        ),
      );
    };
  }

  ElevatedButton workButton(String text, Function ontap) {
    return ElevatedButton(
      style: const ButtonStyle(elevation: MaterialStatePropertyAll(10)),
      onPressed: () {
        ontap();
      },
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}

