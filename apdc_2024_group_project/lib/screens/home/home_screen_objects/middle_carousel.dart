import 'dart:ui';

import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

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
    return  Container(
      child: CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 8),
                scrollDirection: Axis.vertical,
                enableInfiniteScroll: true,
              ),

              items: items.map((item) {
                return  Card(
                  margin: EdgeInsets.all(5),
                  child: InkWell(
                    onTap: () => itemClicked(context, item),
                    child: LayoutBuilder( builder: (context, constraints) {
                      double boxheight = constraints.maxHeight;
                      double boxwidth = constraints.maxWidth;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          Expanded(

                                 child: Image.asset( item['image']!, fit: BoxFit.cover)),

                          SizedBox(
                            height: boxheight/8,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Text(
                                  item['name']!,
                                  style: Theme.of(context).textTheme.displaySmall,
                                  maxLines: 1,
                                ),

                                Text(
                                  item['location']!,
                                  style: Theme.of(context).textTheme.bodySmall,
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ],
                );}
                ),

                ),

                  
                );
              }).toList(),
      ),
    );
  }
}
