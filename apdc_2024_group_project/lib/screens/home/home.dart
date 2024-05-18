import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adc_group_project/screens/objects/menubar.dart';
import 'package:adc_group_project/screens/objects/restaurantbox.dart';
import 'package:adc_group_project/screens/objects/searchbar.dart';
import 'package:adc_group_project/screens/objects/categoryRow.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchContainer(),
                Expanded(
                  child: SingleChildScrollView(
                    child: RestaurantsContainer(),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x80000000),
                      offset: Offset(4, 0),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MenuItem(
                          iconPath: 'assets/vectors/iconhome_2_x2.svg',
                          label: 'Home',
                          labelColor: Color(0xFF222222),
                          iconWidth: 20,
                          iconHeight: 20,
                          iconMargin: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          iconData: Icons.menu_book,
                          label: 'Reservations',
                          labelColor: Color.fromARGB(255, 110, 106, 106),
                          iconWidth: 20,
                          iconHeight: 20,
                          iconMargin: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          iconPath: 'assets/images/image_2.png',
                          label: 'Carbon Footprint',
                          labelColor: Color(0xFF222222),
                          iconWidth: 20,
                          iconHeight: 20,
                          iconMargin: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          iconPath: 'assets/vectors/vector_44_x2.svg',
                          label: 'Favorites',
                          labelColor: Color(0xFF222222),
                          iconWidth: 20,
                          iconHeight: 20,
                          iconMargin: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                        ),
                        MenuItem(
                          iconPath: 'assets/vectors/iconuser_3_x2.svg',
                          label: 'Profile',
                          labelColor: Color(0xFF222222),
                          iconWidth: 20,
                          iconHeight: 20,
                          iconMargin: EdgeInsets.zero,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
