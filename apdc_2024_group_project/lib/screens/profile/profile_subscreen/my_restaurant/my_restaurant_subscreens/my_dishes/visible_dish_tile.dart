import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/dish.dart';

import 'package:flutter/material.dart';

class VisibleDishTile extends StatelessWidget {
  const VisibleDishTile({
    super.key,
    required this.dish,
    required this.hasOnlyOneVisibleDish,
  });

  final Dish dish;
  final bool hasOnlyOneVisibleDish;

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
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      //title: const Text('Warning'),
                      content: const Text(
                          'Are you sure you want to delete this dish? This action cannot be undone.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                            if (hasOnlyOneVisibleDish) {
                              final bool isRestaurantVisible =
                                  await DatabaseService().isRestaurantVisible();
                              if (isRestaurantVisible != null) {
                                if (isRestaurantVisible == true) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Warning'),
                                        content: const Text(
                                            'If you delete this dish, you wont have any visible dishes and your restaurant visiblity wil be turned off. Do you want to proceed?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              await DatabaseService()
                                                  .deleteDish(dish.id);
                                              await DatabaseService()
                                                  .updateRestaurantVisibility(
                                                      false);
                                            },
                                            child: const Text('Proceed'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  await DatabaseService().deleteDish(dish.id);
                                }
                              }
                            } else {
                              await DatabaseService().deleteDish(dish.id);
                            }
                          },
                          child: const Text('Proceed'),
                        ),
                      ],
                    );
                  },
                );
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
                icon: const Icon(Icons.restaurant),
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
                            content: Image.network(value,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text('Error loading image!')),
                          );
                        },
                      );
                    }
                  });
                }),
            IconButton(
              icon: const Icon(Icons.visibility_off),
              onPressed: () async {
                if (hasOnlyOneVisibleDish) {
                  final bool isRestaurantVisible =
                      await DatabaseService().isRestaurantVisible();
                  if (isRestaurantVisible != null) {
                    if (isRestaurantVisible == true) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Warning'),
                            content: const Text(
                                'If you make this dish invisible, you wont have any visible dishes and your restaurant visiblity wil be turned off. Do you want to proceed?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  await DatabaseService().updateDishVisibility(
                                      dish.id, dish.visible);
                                  await DatabaseService()
                                      .updateRestaurantVisibility(false);
                                },
                                child: const Text('Proceed'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      await DatabaseService()
                          .updateDishVisibility(dish.id, dish.visible);
                    }
                  }
                } else {
                  await DatabaseService()
                      .updateDishVisibility(dish.id, dish.visible);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
