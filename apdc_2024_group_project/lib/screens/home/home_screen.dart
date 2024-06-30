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

  // TODO - replace this with actual data
  final List<Map<String, String>> middleCarouselItems = [
      {
        'image': 'assets/images/restaurant1.png',
        'name': 'Restaurante Verde',
        'location': 'Almada',
        'menu': 'name: "Bife à Portuguesa", price: 10.0, description: "Bife com batatas fritas e ovo estrelado"',
      },
      {
        'image': 'assets/images/restaurant2.png',
        'name': 'Restaurante Vermelho',
        'location': 'Algueirão Mem Martins'
      },
      {
        'image': 'assets/images/restaurant3.png',
        'name': 'Restaurante Azul',
        'location': 'Lisboa'
      },
    ];
  
  bool gettingLocation = true;
  bool gettingRestaurants = true;
  LatLng userLocation = const LatLng(0, 0); 
  List<Restaurant> items = [];

  @override
  void initState() {
    getLocation();
    getRestaurants('lisboa');
    super.initState();
  }

  void getRestaurants(String locality) async {
    final DatabaseService db = DatabaseService();
    items = await db.getRestaurantsbyLocality(locality.toLowerCase());

    setState(() {
      gettingRestaurants = false;
    });
  }

  void getLocation() async {
    LocationPermission permission;

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
          gettingLocation = false;
        });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          gettingLocation = false;
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
        setState(() {
          gettingLocation = false;
        });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      userLocation = LatLng(position.latitude, position.longitude);
      gettingLocation = false;
    });
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