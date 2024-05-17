import 'package:flutter/material.dart';

import 'package:flutter_app/pages/achievements_screen.dart';
import 'package:flutter_app/pages/carbon_footprint_screen.dart';
import 'package:flutter_app/pages/create_dish_screen.dart';
import 'package:flutter_app/pages/favorites_screenempty.dart';
import 'package:flutter_app/pages/favorites_screenfilled.dart';
import 'package:flutter_app/pages/help_and_support_screen.dart';
import 'package:flutter_app/pages/home_screen.dart';
import 'package:flutter_app/pages/my_restaurant_screenhas_restaurant.dart';
import 'package:flutter_app/pages/my_restaurant_screenno_restaurant.dart';
import 'package:flutter_app/pages/my_restaurant_screenwaiting_for_approval.dart';
import 'package:flutter_app/pages/personal_information_screenfilled.dart';
import 'package:flutter_app/pages/personalize_screen.dart';
import 'package:flutter_app/pages/profile_screen.dart';
import 'package:flutter_app/pages/promo_codes_screen.dart';
import 'package:flutter_app/pages/reservations_screenempty.dart';
import 'package:flutter_app/pages/reservations_screenfilled.dart';
import 'package:flutter_app/pages/restaurant_page_screenfilled.dart';
import 'package:flutter_app/pages/restaurant_promo_codes_screen.dart';
import 'package:flutter_app/pages/restaurant_reservation_screen.dart';
import 'package:flutter_app/pages/restaurant_reviews_screenempty.dart';
import 'package:flutter_app/pages/restaurant_reviews_screenfilled.dart';
import 'package:flutter_app/pages/restaurant_reviews_screenfilled_1.dart';
import 'package:flutter_app/pages/restaurant_settings_screen.dart';
import 'package:flutter_app/pages/reviews_screenempty.dart';
import 'package:flutter_app/pages/search_screen.dart';
import 'package:flutter_app/pages/settings_screen.dart';
import 'package:flutter_app/pages/sign_in_screen.dart';
import 'package:flutter_app/pages/sign_up_screen.dart';
import 'package:flutter_app/pages/state_off.dart';
import 'package:flutter_app/pages/state_on.dart';
import 'package:flutter_app/pages/view_dishes_screen.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter App',
      home: Scaffold(

        //body: AchievementsScreen(),
        // body: CarbonFootprintScreen(),
        // body: CreateDishScreen(),
        // body: FavoritesScreenempty(),
        // body: FavoritesScreenfilled(),
        // body: HelpAndSupportScreen(),
        // body: HomeScreen(),
        // body: MyRestaurantScreenhasRestaurant(),
        // body: MyRestaurantScreennoRestaurant(),
        // body: MyRestaurantScreenwaitingForApproval(),
        // body: PersonalInformationScreenfilled(),
        // body: PersonalizeScreen(),
        // body: ProfileScreen(),
        // body: PromoCodesScreen(),
        // body: ReservationsScreenempty(),
        // body: ReservationsScreenfilled(),
        // body: RestaurantPageScreenfilled(),
        // body: RestaurantPromoCodesScreen(),
        // body: RestaurantReservationScreen(),
        // body: RestaurantReviewsScreenempty(),
        // body: RestaurantReviewsScreenfilled(),
        // body: RestaurantReviewsScreenfilled1(),
        // body: RestaurantSettingsScreen(),
        // body: ReviewsScreenempty(),
        // body: SearchScreen(),
        // body: SettingsScreen(),
         body: SignInScreen(),
        // body: SignUpScreen(),
        // body: StateOff(),
        // body: StateOn(),
        // body: ViewDishesScreen(),

      ),
    );
  }
}
