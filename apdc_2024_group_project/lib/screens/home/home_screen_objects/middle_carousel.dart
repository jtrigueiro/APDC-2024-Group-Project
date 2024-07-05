import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MiddleCarousel extends StatelessWidget {
  final List<Restaurant> items;

  const MiddleCarousel({required this.items, super.key});

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void itemClicked(context, Restaurant item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RestaurantScreen(info: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 8),
        scrollDirection: Axis.vertical,
        enableInfiniteScroll: true,
      ),
      items: items.map((item) {
        return Card(
          margin: const EdgeInsets.all(5),
          child: InkWell(
            onTap: () => itemClicked(context, item),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        8.0), // Adjust the border radius as needed
                    child: Image.asset(
                      'assets/images/restaurant1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.name,
                      style: Theme.of(context).textTheme.displaySmall,
                      maxLines: 1,
                    ),
                    Text(
                      item.location,
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
