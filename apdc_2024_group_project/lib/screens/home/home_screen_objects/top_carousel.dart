import 'package:adc_group_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopCarousel extends StatelessWidget {
  final List<String> images;

  const TopCarousel({required this.images, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 100,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 7),
          scrollDirection: Axis.horizontal,
          viewportFraction:
              MediaQuery.of(context).size.width > 600 ? 0.1 : 0.25,
          enableInfiniteScroll: true,
        ),
        items: images.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
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
                      borderRadius: BorderRadius.circular(30.0),
                      child: Container(
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
                  SizedBox(height: 6.0),
                  Text(
                    item.split('/').last.split('.').first.capitalize(),
                    style: TextStyle(fontSize: 10.0),
                  )
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
