import 'dart:ui';

import 'package:adc_group_project/screens/home/search_restaurants/restaurant/restaurant_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';

class MiddleCarousel extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const MiddleCarousel({required this.items, super.key});

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void itemClicked(context, Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RestaurantScreen(info: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //double screenHeight = MediaQuery.of(context).size.height;

    //double cardHeight = screenHeight * 0.2;
    //TODO: check the card height and width

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
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                      child: Image.asset(
                          'assets/images/restaurant1.png',
                          fit: BoxFit.cover),
                  ),

                  Column(
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
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
