import 'dart:convert';

import 'package:adc_group_project/screens/home/search_restaurants/search_restaurants_screen.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/utils/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/searchbar.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/top_carousel.dart';
import 'package:adc_group_project/screens/home/home_screen_objects/middle_carousel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

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
      if(value) {
        getLocal(userLocation);
      }
      else {
        getRestaurants('lisboa');
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
          final local = json['results'][0]['address_components'][size - 3]['long_name'];

          getRestaurants(local.toLowerCase());
        }
      }
    });
  }

  void getRestaurants(String local) async {
    final DatabaseService db = DatabaseService();
    items = await db.getRestaurantsbyLocation(local.toLowerCase());

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
      MaterialPageRoute(builder: (context) => SearchScreen(userLocation: userLocation,)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return (gettingLocation || gettingRestaurants) ? const LoadingScreen() : Column(
          children: [
            const SizedBox(height: 20.0),
            SearchButton(onPressed: () => _onSearchPressed(context, userLocation)),
            TopCarousel(images: topCarouselImages),
            Expanded(child: MiddleCarousel(items: items)),
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