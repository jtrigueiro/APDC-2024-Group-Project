import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/my_Dishes_subscreens/my_dishes_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/my_restaurant_settings_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/promo_codes_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_subscreens/restaurant_personalize_screen.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:flutter/material.dart';
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
      body: Scrollbar(
        controller: scrollController,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ListView(shrinkWrap: true, children: [
              Text('Restaurant name maybe?', style: Theme.of(context).textTheme.titleLarge),
              Text('location maybe?', style: Theme.of(context).textTheme.bodyMedium),

              customSpaceBetweenColumns(40),
              tiles('Personalize', Icons.warehouse, toPersonalizePage),
              tiles('My Dishes', Icons.food_bank, toMyDishesPage),
              tiles('Reviews', Icons.star, () {}),
              tiles('PromoCodes', Icons.card_giftcard, toPromoCodesPage),
              tiles('Settings', Icons.settings, toMyRestaurantSettingsPage),
            ]),
          ),
        ),
      ),
    );
  }

  ListTile tiles(String text, IconData icon, Function ontapFunction) {
    return ListTile(
        title: Text(text, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.secondary)),
        leading: Icon(icon, color: Theme.of(context).colorScheme.secondary,),
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

  Future toMyDishesPage() {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyDishesScreen(),
      ),
    );
  }

  Future toPromoCodesPage() {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PromoCodesScreen(),
      ),
    );
  }

  Future toMyRestaurantSettingsPage() {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MyRestaurantSettingsScreen(),
      ),
    );
  }

  Text texts(String text, double size) {
    return Text(
      text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: const Color(0xFF000000),
      ),
    );
  }
}
