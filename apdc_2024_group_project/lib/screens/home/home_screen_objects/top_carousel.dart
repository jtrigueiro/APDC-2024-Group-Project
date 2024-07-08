import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:adc_group_project/services/firestore_database.dart';

class TopCarousel extends StatelessWidget {
  final List<String> images;
  final Function(List<Restaurant>) onFilterApplied;

  const TopCarousel(
      {required this.images, required this.onFilterApplied, Key? key})
      : super(key: key);

  void itemClicked(BuildContext context, String item) async {
    final DatabaseService db = DatabaseService();
    String type = item.split('/').last.split('.').first.toLowerCase();
    List<Restaurant> filteredRestaurants = await db.getRestaurantsByType(type);
    onFilterApplied(filteredRestaurants);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.2,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 7),
          scrollDirection: Axis.horizontal,
          viewportFraction:
              MediaQuery.of(context).size.width > 600 ? 0.15 : 0.25,
          enableInfiniteScroll: true,
        ),
        items: images.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return InkWell(
                onTap: () => itemClicked(context, item),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: Container(
                        width: containerSize(context),
                        height: containerSize(context),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage(item),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        item.split('/').last.split('.').first.capitalize(),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  double containerSize(BuildContext context) {
    if (kIsWeb) {
      return MediaQuery.of(context).size.width * 0.1;
    } else {
      return MediaQuery.of(context).size.width * 0.2;
    }
  }
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
