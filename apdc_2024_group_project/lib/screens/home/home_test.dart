import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final List<String> topCarouselImages = [
    'assets/images/italian.png',
    'assets/images/burger.png',
    'assets/images/traditional.png',
    'assets/images/sushi.png',
  ];
  final List<Map<String, String>> middleCarouselItems = [
    {
      'image': 'assets/images/restaurant1.png',
      'name': 'Restaurante Verde',
      'location': 'Almada'
    },
    {
      'image': 'assets/images/restaurant2.png',
      'name': 'Restaurante Vermelho',
      'location': 'Algueirão Nem Martins'
    },
    {
      'image': 'assets/images/restaurant3.png',
      'name': 'Restaurante Azul',
      'location': 'Lisboa'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search for Restaurants',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 100.0,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    scrollDirection: Axis.horizontal,
                    viewportFraction: 0.3,
                    enableInfiniteScroll: true,
                  ),
                  items: topCarouselImages.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(item,
                                  fit: BoxFit.cover, height: 60.0, width: 60.0),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                                item
                                    .split('/')
                                    .last
                                    .split('.')
                                    .first
                                    .capitalize(),
                                style: TextStyle(fontSize: 12.0))
                          ],
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: double.infinity,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 4),
                    scrollDirection: Axis.vertical,
                    viewportFraction: constraints.maxWidth > 600 ? 0.5 : 0.9,
                    enableInfiniteScroll: true,
                  ),
                  items: middleCarouselItems.map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: constraints.maxWidth > 600
                                    ? 400
                                    : MediaQuery.of(context).size.width * 0.8,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Image.asset(item['image']!,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(item['name']!,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              Text(item['location']!,
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Reservations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.eco),
            label: 'Carbon Footprint',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.amber[800],
        onTap: (index) {
          // Handle bottom nav bar tap
        },
      ),
    );
  }
}

extension StringCasingExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
