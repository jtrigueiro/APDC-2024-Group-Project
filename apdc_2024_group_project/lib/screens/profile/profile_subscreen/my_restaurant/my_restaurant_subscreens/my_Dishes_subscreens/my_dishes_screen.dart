import 'package:adc_group_project/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'create_dish_screen.dart';

class MyDishesScreen extends StatefulWidget {
  MyDishesScreen({super.key});

  @override
  State<MyDishesScreen> createState() => MyDishesScreenState();
}

class MyDishesScreenState extends State<MyDishesScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final ingredients = Provider.of<List<Ingredient>?>(context) ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Dishes'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color.fromARGB(255, 117, 85, 18)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              //dishes ver se tem

              customSpaceBetweenColumns(25),
              Text('Add Dishes', style: Theme.of(context).textTheme.titleLarge),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateDishesScreen(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
              /*  Row(ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          return RestaurantIngredientTile(ingredient: ingredients[index]);
        });)*/
            ],
          ),
        ),
      ),
    );
  }
}
