import 'package:flutter/material.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:adc_group_project/services/firestore_database.dart';

class RestaurantMenu extends StatelessWidget {
  final Restaurant info;

  const RestaurantMenu({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final Future<List<Dish>> dishesFuture =
        DatabaseService().getAllRestaurantDishes(info.id);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            child: const Text(
              "Menu",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FutureBuilder<List<Dish>>(
            future: dishesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No dishes available'));
              } else {
                final dishes = snapshot.data!;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dishes.length,
                  itemBuilder: (context, index) {
                    final dish = dishes[index];
                    return FutureBuilder(
                      future: DatabaseService()
                          .getDishImageUrlUsers(info.id, dish.id),
                      builder: (context, imageSnapshot) {
                        if (imageSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (imageSnapshot.hasError ||
                            !imageSnapshot.hasData) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/burger.png',
                                fit: BoxFit.cover,
                                width: 50.0,
                                height: 50.0,
                              ),
                            ),
                            title: Text(dish.name),
                            subtitle: Text(dish.description),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${dish.co2} CO2e"),
                              ],
                            ),
                          );
                        } else {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imageSnapshot.data as String,
                                fit: BoxFit.cover,
                                width: 50.0,
                                height: 50.0,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/burger.png',
                                    fit: BoxFit.cover,
                                    width: 50.0,
                                    height: 50.0,
                                  );
                                },
                              ),
                            ),
                            title: Text(dish.name),
                            subtitle: Text(dish.description),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("${dish.co2} CO2e"),
                              ],
                            ),
                          );
                        }
                      },
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
