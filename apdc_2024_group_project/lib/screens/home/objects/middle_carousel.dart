import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MiddleCarousel extends StatelessWidget {
  final List<Map<String, String>> items;

  const MiddleCarousel({required this.items, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 4),
          scrollDirection: Axis.vertical,
          viewportFraction: MediaQuery.of(context).size.width > 600 ? 0.7 : 0.5,
          enableInfiniteScroll: true,
        ),
        items: items.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width > 600
                          ? 400
                          : MediaQuery.of(context).size.width * 0.85,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Image.asset(item['image']!, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(item['name']!,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold)),
                    Text(item['location']!,
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
