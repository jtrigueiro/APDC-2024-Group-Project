import 'package:adc_group_project/screens/back_office/helps_and_support_list.dart';
import 'package:adc_group_project/screens/back_office/ingredients/restaurants_ingredients_screen.dart';
import 'package:adc_group_project/screens/back_office/promo_codes/promo_code_main_page.dart';
import 'package:adc_group_project/screens/back_office/restaurant_types/restaurant_types%20management.dart';
import 'package:adc_group_project/screens/back_office/restaurants_applications/restaurants_applications_screen.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:flutter/material.dart';

class BackOfficeHomeScreen extends StatelessWidget {
  BackOfficeHomeScreen({super.key});

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back Office'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            workButton('Restaurants Requests', restaurantRequests(context)),
            workButton('Help and Support', supportTap(context)),
            workButton('PromoCode Management', promoCodesTap(context)),
            workButton('Ingredients Management', ingredientsTap(context)),
            workButton('Restaurant Types Management',
                restaurantTypesManagementTap(context)),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              style: const ButtonStyle(
                  elevation: MaterialStatePropertyAll(10),
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton workButton(String text, Function ontap) {
    return ElevatedButton(
      style: const ButtonStyle(elevation: MaterialStatePropertyAll(10)),
      onPressed: () {
        ontap();
      },
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  Function supportTap(context) {
    return () {
      Navigator.of(context).push(CustomPageRoute(
        builder: (context) => SupportMessagesListScreen(),
      ));
    };
  }

  Function restaurantRequests(context) {
    return () {
      Navigator.of(context).push(CustomPageRoute(
        builder: (context) => RestaurantsApplicationsScreen(),
      ));
    };
  }

  Function promoCodesTap(context) {
    return () {
      Navigator.of(context).push(CustomPageRoute(
        builder: (context) => PromoCodesHomeScreen(),
      ));
    };
  }

  Function ingredientsTap(context) {
    return () {
      Navigator.of(context).push(CustomPageRoute(
        builder: (context) => RestaurantsIngredientsScreen(),
      ));
    };
  }

  Function restaurantTypesManagementTap(context) {
    return () {
      Navigator.of(context).push(CustomPageRoute(
        builder: (context) => RestaurantTypesManagementPage(),
      ));
    };
  }
}

class CustomPageRoute extends MaterialPageRoute {
  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  CustomPageRoute({builder}) : super(builder: builder);
}
