import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:flutter/material.dart';

class HiddenDishTile extends StatelessWidget {
  const HiddenDishTile({super.key, required this.dish});

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
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              tooltip:'Delete dish' ,
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
                            await DatabaseService().deleteDish(dish.id);
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
                tooltip: 'View dish description',
                icon: const Icon(Icons.restaurant,color: Colors.blueGrey),
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
                tooltip: 'View dish image',
                icon: const Icon(Icons.image_outlined,color: Colors.blueAccent),
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
              tooltip: 'Display dish ',
              icon:  Icon(Icons.visibility, color:Theme.of(context).colorScheme.primary),
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
