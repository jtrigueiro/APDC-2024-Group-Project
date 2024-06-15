
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/my_dishes_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/restaurant_personalize_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRestaurantScreen extends StatefulWidget {
  const MyRestaurantScreen({super.key});

  @override
  State<MyRestaurantScreen> createState() => MyRestaurantScreenState();
}

class MyRestaurantScreenState extends State<MyRestaurantScreen> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[100],
        title: texts('My Restaurant', 20),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(20),

            child: ListView(shrinkWrap: true, children: [
              tiles('Personalize', Icons.warehouse, toPersonalizePage),
              tiles('My Dishes', Icons.food_bank, () {}),
              tiles('Reviews', Icons.star, () {}),
              tiles('PromoCodes', Icons.card_giftcard, () {}),
              tiles('Settings', Icons.settings, () {}),
            ]),


          ),
        ),
      ),
    );
  }

  ListTile tiles(String text, IconData icon, Function ontapFunction) {
    return ListTile(
        title: texts(text, 20),
        leading: Icon(icon),
        onTap: () {
          ontapFunction();
        });
  }

  Future toPersonalizePage() {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RestaurantPersonalizeScreen(),
      ),
    );
  }


  Future toMyDishesPage ()
  {
    return Navigator.of(context).push( MaterialPageRoute(
      builder: (context) => MyDishesScreen(),),
    );
  }



  Text texts(String text, double size)
  {
    return Text(text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: const Color(0xFF000000),
      ),
    );
  }
}
