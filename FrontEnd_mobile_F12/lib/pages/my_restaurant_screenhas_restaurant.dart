import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRestaurantScreenhasRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 434),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 61),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x3B34A853),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(18.3, 13, 0, 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 3.7, 0, 8.7),
                        width: 10.8,
                        height: 21.6,
                        child: SizedBox(
                          width: 10.8,
                          height: 21.6,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_16_x2.svg',
                          ),
                        ),
                      ),
                      Text(
                        'My Restaurant',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w400,
                          fontSize: 25,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(29, 0, 29, 11),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 4, 9.4, 7),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          'assets/vectors/group_5_x2.svg',
                        ),
                      ),
                    ),
                    Text(
                      'Personalize',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w200,
                        fontSize: 30,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(31, 0, 31, 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10.3, 0.7),
                      child: SizedBox(
                        width: 26.9,
                        height: 41.3,
                        child: SvgPicture.asset(
                          'assets/vectors/group_8_x2.svg',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                      child: Text(
                        'My Dishes',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w200,
                          fontSize: 30,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(32, 0, 32, 11),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 6, 12.1, 5),
                      child: SizedBox(
                        width: 24,
                        height: 30,
                        child: SvgPicture.asset(
                          'assets/vectors/iconfile_text_1_x2.svg',
                        ),
                      ),
                    ),
                    Text(
                      'Reviews',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w200,
                        fontSize: 30,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(29, 0, 29, 11),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 6, 9.4, 5),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          'assets/vectors/icongift_x2.svg',
                        ),
                      ),
                    ),
                    Text(
                      'Promo codes',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w200,
                        fontSize: 30,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(29, 0, 29, 0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 6, 9.4, 5),
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: SvgPicture.asset(
                          'assets/vectors/iconsettings_x2.svg',
                        ),
                      ),
                    ),
                    Text(
                      'Settings',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w200,
                        fontSize: 30,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}