import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/dish.dart';

import 'package:flutter/material.dart';

class VisibleDishTile extends StatelessWidget {
  const VisibleDishTile({super.key, required this.dish});

  final Dish dish;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                await DatabaseService().deleteDish(dish.id);
              },
            ),
            Expanded(
              child: ListTile(
                title: Text(dish.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Price: ${dish.price} €'),
                    Text('CO2: ${dish.co2} grams'),
                  ],
                ),
              ),
            ),
            IconButton(
                icon: const Icon(Icons.food_bank_outlined),
                onPressed: () async {
                  await DatabaseService()
                      .getDishListOfIngredients(dish.id)
                      .then((value) {
                    if (value != null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Description: ${dish.description}',
                                      textAlign: TextAlign.left),
                                  ...value.map((e) => ListTile(
                                        title: Text(e.name),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Weight: ${e.grams} grams'),
                                            Text('CO2: ${e.co2} grams'),
                                          ],
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  });
                }),
            IconButton(
                icon: const Icon(Icons.image_outlined),
                onPressed: () async {
                  await DatabaseService()
                      .getDishImageUrl(dish.id)
                      .then((value) {
                    if (value != null) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Image.network(value),
                          );
                        },
                      );
                    }
                  });
                }),
            IconButton(
              icon: const Icon(Icons.visibility_off),
              onPressed: () async {
                await DatabaseService()
                    .updateDishVisibility(dish.id, dish.visible);
              },
            ),
          ],
        ),
      ),
    );
  }
}
