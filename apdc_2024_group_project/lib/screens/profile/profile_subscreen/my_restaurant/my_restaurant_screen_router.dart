import 'package:adc_group_project/screens/profile/profile_subscreen/help_and_support/help_and_support.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/my_restaurant_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/no_restaurant_screen.dart';
import 'package:adc_group_project/screens/profile/profile_subscreen/my_restaurant/restaurant_requested_screen.dart';
import 'package:adc_group_project/services/auth.dart';
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
  final AuthService _auth = AuthService();
  bool loading = true;

  /*final screens = [
    NoRestaurantScreen(),
    RestaurantRequestScreen(),
    MyRestaurantScreen(),
  ];

  @override
  void initState() {
    checkCurrentIndex();
    scrollController = ScrollController();

    super.initState();
  }*/

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
    var status = await _auth.hasRestaurantApplication();
    if (status != false) {
      if (status) {
        setState(() {
          _currentIndex = 1;
          loading = false;
        });
      } else {
        Navigator.pop(context);
      }
    } else {
      setState(() {
        _currentIndex = 0;
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const LoadingScreen()
        : Scaffold(
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
