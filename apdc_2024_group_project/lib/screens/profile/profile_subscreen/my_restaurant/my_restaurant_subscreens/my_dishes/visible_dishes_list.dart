import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/my_dishes/visible_dish_tile.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VisibleDishesList extends StatefulWidget {
  const VisibleDishesList({super.key});

  @override
  State<VisibleDishesList> createState() => _VisibleDishesListState();
}

class _VisibleDishesListState extends State<VisibleDishesList> {
  @override
  Widget build(BuildContext context) {
    final dishes = Provider.of<List<Dish>?>(context) ?? [];
    final hidenDishes = dishes.where((dish) => dish.visible).toList();
    return ListView.builder(
        itemCount: hidenDishes.length,
        itemBuilder: (context, index) {
          return VisibleDishTile(dish: hidenDishes[index]);
        });
  }
}
