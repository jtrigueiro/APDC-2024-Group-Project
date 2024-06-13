import 'package:adc_group_project/screens/authenticate/sign_in_screen.dart';
import 'package:adc_group_project/screens/navigation_bar.dart';
import 'package:adc_group_project/screens/restaurant/restaurant_personalize_screen.dart';
import 'package:adc_group_project/screens/restaurant/restaurant_requested_screen.dart';
import 'package:adc_group_project/screens/restaurant/no_restaurant_screen.dart';
import 'package:adc_group_project/screens/restaurant/restaurant_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:adc_group_project/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser?>(context);
    if (user == null) {
      return RestaurantScreen();
      //return SignInScreen();
    } else {
      return HomeRouter();
    }
  }
}
