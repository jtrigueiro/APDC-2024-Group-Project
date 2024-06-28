import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/my_dishes/hidden_dishes_list.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/my_dishes/visible_dishes_list.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/dish.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_dish_screen.dart';

class MyDishesScreen extends StatefulWidget {
  MyDishesScreen({super.key});

  @override
  State<MyDishesScreen> createState() => MyDishesScreenState();
}

class MyDishesScreenState extends State<MyDishesScreen> {
  late ScrollController scrollController;
  //final dishes = Provider.of<List<Dish>?>(context) ?? [];
  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: StreamProvider<List<Dish>?>.value(
        initialData: null,
        value: DatabaseService().dishes,
        child: Scaffold(
            appBar: AppBar(
              bottom: const TabBar(
                unselectedLabelColor: Color.fromARGB(255, 117, 85, 18),
                labelColor: Color.fromARGB(255, 255, 255, 255),
                //indicatorColor: Color.fromARGB(255, 255, 255, 255),
                tabs: [
                  Tab(
                    icon: Icon(Icons.visibility),
                    text: 'Visible',
                  ),
                  Tab(
                    icon: Icon(Icons.visibility_off),
                    text: 'Hidden',
                  ),
                ],
              ),
              title: const Text('My Dishes'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Color.fromARGB(255, 117, 85, 18)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  color: Color.fromARGB(255, 255, 255, 255),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CreateDishesScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: const TabBarView(
              children: [VisibleDishesList(), HiddenDishesList()],
            )),
      ),
    );
  }
}
