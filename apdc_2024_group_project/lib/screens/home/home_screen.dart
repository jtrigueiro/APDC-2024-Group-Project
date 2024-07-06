import 'dart:convert';

import 'package:adc_group_project/screens/home/search_restaurants/search_restaurants_screen.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/utils/constants.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/searchbar.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/top_carousel.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/middle_carousel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart' show kIsWeb;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> topCarouselImages = [
    'assets/images/italian.png',
    'assets/images/burger.png',
    'assets/images/traditional.png',
    'assets/images/sushi.png',
  ];

  final String apiKey = 'AIzaSyBYDIEadA1BKbZRNEHL1WFI8PWFdXKI5ug';

  bool gettingLocation = true;
  bool gettingRestaurants = true;
  LatLng userLocation = const LatLng(.736946, -9.142685);
  List<Restaurant> items = [];

  @override
  void initState() {
    getLocation().then((value) {
      if (value) {
        getLocal(userLocation);
      } else {
        getRestaurants('amadora');
      }
    });
    super.initState();
  }

  void getLocal(LatLng coordinates) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=${coordinates.latitude},${coordinates.longitude}&key=$apiKey');
    http.get(url).then((response) async {
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        if (json['status'] == 'OK') {
          final size = json['results'][0]['address_components'].length;
          final local =
              json['results'][0]['address_components'][size - 3]['long_name'];

          getRestaurants(local.toLowerCase());
        }
      }
    });
  }

  void getRestaurants(String local) async {
    final DatabaseService db = DatabaseService();
    items = await db.getRestaurantsbyLocation(local.toLowerCase());

    if (items.isEmpty) {
      items = await db.getRestaurantsbyLocation('amadora');
    }

    setState(() {
      gettingRestaurants = false;
    });
  }

  Future<bool> getLocation() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        gettingLocation = false;
      });
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          gettingLocation = false;
        });
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        gettingLocation = false;
      });
      return false;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      gettingLocation = false;
    });

    return true;
  }

  void _onSearchPressed(BuildContext context, LatLng userLocation) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SearchScreen(
                userLocation: userLocation,
              )),
    );
  }

  //todo: rever web
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: Container(
              color: Theme.of(context).colorScheme.background,
              child: web(context)),
        ),
      );
    } else {
      return web(context);
    }
  }

  Widget web(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return (gettingLocation || gettingRestaurants)
            ? const LoadingScreen()
            : Column(
                children: [

                  Material(
                    elevation: 1,
                    shadowColor: Theme.of(context).colorScheme.primary,
                    child:
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: SearchButton(
                                  onPressed: () =>
                                      _onSearchPressed(context, userLocation)),
                            ),

                            TopCarousel(images: topCarouselImages),
                          ],
                        ),

                    ),

                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: MiddleCarousel(items: items),
                  )),
                ],
              );
      },
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
