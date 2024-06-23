import 'package:adc_group_project/screens/back_office/ingredients/restaurants_ingredients_list.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:adc_group_project/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart'; // Add this line

class RestaurantsIngredientsScreen extends StatelessWidget {
  const RestaurantsIngredientsScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Ingredient>?>.value(
      initialData: null,
      value: DatabaseService().ingredients,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Restaurants Ingredients'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Color.fromARGB(255, 204, 178, 133)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              color: Color.fromARGB(255, 204, 178, 133),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String ingredientName = '';
                    String co2 = '';
                    String grams = ''; // Add this line

                    return AlertDialog(
                      title: const Text('Add Ingredient'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Ingredient Name',
                              ),
                              onChanged: (value) {
                                ingredientName = value;
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'Ingredient weight in grams',
                              ),
                              onChanged: (value) {
                                grams = value;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: TextField(
                              decoration: const InputDecoration(
                                labelText: 'CO2 weight in grams',
                              ),
                              onChanged: (value) {
                                co2 = value;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Add'),
                          onPressed: () {
                            if (ingredientName.isNotEmpty &&
                                co2.isNotEmpty &&
                                grams.isNotEmpty) {
                              DatabaseService().addOrUpdateIngredient(
                                ingredientName,
                                int.parse(co2),
                                int.parse(grams),
                              );
                              Navigator.of(context).pop();
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Error'),
                                    content: const Text(
                                        'Please fill in all fields.'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: RestaurantsIngredientsList(),
      ),
    );
  }
}
