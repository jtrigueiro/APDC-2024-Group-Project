import 'package:adc_group_project/screens/profile/profile_subscreen/help_and_support/help_and_support.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/no_restaurant_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/restaurant_requested_screen.dart';
import 'package:adc_group_project/services/auth.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRestaurantScreenRouter extends StatefulWidget {
  const MyRestaurantScreenRouter({super.key});

  @override
  State<MyRestaurantScreenRouter> createState() =>
      _MyRestaurantScreenRouterState();
}

class _MyRestaurantScreenRouterState extends State<MyRestaurantScreenRouter> {
  late ScrollController scrollController;
  late int _currentIndex;
  bool loading = true;

  var screens = [];

  @override
  void initState() {
    checkCurrentIndex();
    scrollController = ScrollController();
    screens = [
      NoRestaurantScreen(checkCurrentIndex: checkCurrentIndex),
      RestaurantRequestScreen(),
      MyRestaurantScreen(),
    ];
    super.initState();
  }

  checkCurrentIndex() async {
    var status = await DatabaseService().hasRestaurant();
    // if the user has a restaurant
    if (status == true) {
      setState(() {
        _currentIndex = 2; // MyRestaurantScreen
        loading = false;
      });
      // if there is a network error
    } else if (status == null) {
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      // else the user does not have a restaurant but can have a restaurant application or not
    } else {
      status = await DatabaseService().hasRestaurantApplication();
      // if the user has a restaurant application
      if (status == true) {
        setState(() {
          _currentIndex = 1; // RestaurantRequestScreen
          loading = false;
        });
        // if there is a network error
      } else if (status == null) {
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
        // else the user does not have a restaurant application (or a restaurant)
      } else {
        setState(() {
          _currentIndex = 0; // NoRestaurantScreen
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
            appBar: AppBar(
              title: const Text('My Restaurant'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded,
                    color: Color.fromARGB(255, 117, 85, 18)),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: screens[_currentIndex],
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
