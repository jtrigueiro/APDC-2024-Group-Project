import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:adc_group_project/utils/co2_color.dart';
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
      MaterialPageRoute(
          builder: (context) => RestaurantScreen(
                info: item,
                day: null,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        viewportFraction: 0.5,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 8),
        scrollDirection: Axis.vertical,
        enableInfiniteScroll: true,
      ),
      items: items.map((item) {
        return InkWell(
          onTap: () => itemClicked(context, item),
          child: Card(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(item.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            children: [
                              Icon(
                                Icons.star_half,
                                color: Colors.amberAccent,
                              ),
                            ],
                          ),
                          Text(
                            item.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                          ),
                          Icon(
                            Icons.eco,
                            color: CO2ColorCalculator.getColorForRestaurantCO2(
                                item.co2EmissionEstimate),
                          ),
                        ],
                      ),
                      Text(
                        item.location.capitalize(),
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
