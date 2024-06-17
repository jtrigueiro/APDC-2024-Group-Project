import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MiddleCarousel extends StatelessWidget {
  final List<Map<String, String>> items;

  const MiddleCarousel({required this.items, super.key});

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getRestaurantInfo(String id) {
    final db = FirebaseFirestore.instance.collection('restaurants');
    final data = db.where('id', isEqualTo: id).get();
    return data;
  }

  void itemClicked(context, Map<String, String> item) async {
    var queryResult = await getRestaurantInfo(item['id']!);
    var info = queryResult.docs.first.data();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RestaurantScreen(info: info)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 6),
          scrollDirection: Axis.vertical,
          viewportFraction: MediaQuery.of(context).size.width > 600 ? 0.7 : 0.5,
          enableInfiniteScroll: true,
        ),
        items: items.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Center(
                child: InkWell(
                  onTap: () => itemClicked(context, item),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width > 600
                            ? 400
                            : MediaQuery.of(context).size.width * 0.85,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Image.asset(
                            item['image']!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item['name']!,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              item['location']!,
                              style: const TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
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
            },
          );
        }).toList(),
      ),
    );
  }
}
