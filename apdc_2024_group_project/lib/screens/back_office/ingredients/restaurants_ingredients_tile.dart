import 'package:adc_group_project/services/database.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:flutter/material.dart';

class RestaurantIngredientTile extends StatelessWidget {
  const RestaurantIngredientTile({super.key, required this.ingredient});

  final Ingredient ingredient;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text(ingredient.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('CO2: ${ingredient.co2} grams'),
                  ],
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () async {
                await DatabaseService().deleteIngredient(ingredient.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
