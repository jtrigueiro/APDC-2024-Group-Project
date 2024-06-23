import 'package:adc_group_project/screens/back_office/ingredients/restaurants_ingredients_tile.dart';
import 'package:adc_group_project/services/models/ingredient.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsIngredientsList extends StatefulWidget {
  const RestaurantsIngredientsList({super.key});

  @override
  State<RestaurantsIngredientsList> createState() =>
      _RestaurantsIngredientsListState();
}

class _RestaurantsIngredientsListState
    extends State<RestaurantsIngredientsList> {
  @override
  Widget build(BuildContext context) {
    final ingredients = Provider.of<List<Ingredient>?>(context) ?? [];

    return ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return RestaurantIngredientTile(ingredient: ingredients[index]);
        });
  }
}
