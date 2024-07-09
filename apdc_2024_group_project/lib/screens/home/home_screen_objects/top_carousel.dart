import 'package:adc_group_project/screens/home/home_screen.dart';
import 'package:adc_group_project/services/firestore_database.dart';
import 'package:adc_group_project/services/models/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopCarousel extends StatefulWidget {
  final List<String> images;
  final Function(List<Restaurant>) onFilterApplied;
  final Function onFilterCleared;

  const TopCarousel({
    required this.images,
    required this.onFilterApplied,
    required this.onFilterCleared,
    Key? key,
  }) : super(key: key);

  @override
  _TopCarouselState createState() => _TopCarouselState();
}

class _TopCarouselState extends State<TopCarousel> {
  String? selectedType;

  void _filterRestaurants(String type) async {
    if (selectedType == type) {
      // Clear filter if the same type is selected again
      setState(() {
        selectedType = null;
      });
      widget.onFilterCleared();
    } else {
      // Apply new filter
      setState(() {
        selectedType = type;
      });
      final DatabaseService db = DatabaseService();
      final filteredRestaurants = await db.getRestaurantsByType(type);
      widget.onFilterApplied(filteredRestaurants);
    }
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
        items: widget.images.map((item) {
          final type = item.split('/').last.split('.').first;
          final isSelected = selectedType == type;

          return GestureDetector(
            onTap: () => _filterRestaurants(type),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Container(
                    width: containerSize(context),
                    height: containerSize(context),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: isSelected
                          ? Border.all(
                              color: const Color.fromARGB(214, 20, 20, 72),
                              width: 3.0,
                            )
                          : null,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        child: Container(
                          width: containerSize(context),
                          height: containerSize(context),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(item),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    type.capitalize(),
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        fontSize: carouselletterSize(context)),
                  ),
                )
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  double carouselletterSize(context)
  {
    if (kIsWeb) {
      return MediaQuery.of(context).size.height * 0.02;
    } else {
      return MediaQuery.of(context).size.width * 0.035;
    }

  }
  double containerSize(context) {
    if (kIsWeb) {
      return MediaQuery.of(context).size.height * 0.13;
    } else {
      return MediaQuery.of(context).size.width * 0.2;
    }
  }
}
