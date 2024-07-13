import 'package:flutter/material.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/co2_color.dart';

class RestaurantMenu extends StatelessWidget {
  final Restaurant info;

  const RestaurantMenu({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    final Future<List<Dish>> dishesFuture =
        DatabaseService().getAllRestaurantDishes(info.id);

    return SingleChildScrollView(
      child: FutureBuilder<List<Dish>>(
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
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                  child: FutureBuilder(
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
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${dish.co2} CO2e"),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.eco,
                                    color:
                                        CO2ColorCalculator.getColorForDishCO2(
                                            dish.co2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else {
                        return ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor: const Color.fromARGB(19, 94, 88, 88),
                          leading: InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      backgroundColor: Colors.blueGrey,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image.network(
                                          imageSnapshot.data as String,
                                          fit: BoxFit.cover,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.3,
                                        ),
                                      ),
                                    );
                                  });
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Image.network(
                                imageSnapshot.data as String,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/burger.png',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          title: Text(dish.name),
                          subtitle: Text(dish.description),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text("${dish.co2} CO2e"),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.eco,
                                    color:
                                        CO2ColorCalculator.getColorForDishCO2(
                                            dish.co2),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
