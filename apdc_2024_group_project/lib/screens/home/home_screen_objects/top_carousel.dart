import 'package:adc_group_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TopCarousel extends StatelessWidget {
  final List<String> images;

  const TopCarousel({required this.images, Key? key}) : super(key: key);

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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.1,
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
