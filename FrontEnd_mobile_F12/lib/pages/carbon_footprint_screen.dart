import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CarbonFootprintScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 65, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(33.1, 0, 0, 39),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 2.5, 2.1, 2.5),
                    child: Text(
                      'My Carbon Footprint',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border(
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(
                          'assets/images/image_2.png',
                        ),
                      ),
                    ),
                    child: Container(
                      width: 31,
                      height: 32,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 51),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    child: SizedBox(
                      width: 212,
                      height: 208,
                      child: SvgPicture.asset(
                        'assets/vectors/ellipse_7_x2.svg',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30.8,
                    child: SizedBox(
                      width: 148.2,
                      height: 145.4,
                      child: SvgPicture.asset(
                        'assets/vectors/ellipse_8_x2.svg',
                      ),
                    ),
                  ),
            Container(
                    width: 212,
                    padding: EdgeInsets.fromLTRB(0, 91, 0, 90),
                    child: Text(
                      '0.0 ton CO2',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(27, 0, 27, 62.5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 1, 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 14.1, 0),
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: SvgPicture.asset(
                                'assets/vectors/vector_47_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 7, 0, 6),
                            child: Text(
                              '0.0',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 14.1, 0),
                          child: SizedBox(
                            width: 41,
                            height: 30,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_51_x2.svg',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 1, 0, 2),
                          child: Text(
                            '0.0',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(27.3, 0, 27.3, 187.5),
              child: Text(
                'No Carbon Footprint registered yet',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Color(0xFF222222),
                ),
              ),
            ),
            Container(
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
              child: Container(
                padding: EdgeInsets.fromLTRB(21.2, 7, 23.5, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 1, 31, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(2.7, 0, 1.7, 1),
                              child: SizedBox(
                                width: 17.7,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/vectors/iconhome_4_x2.svg',
                                ),
                              ),
                            ),
                            Text(
                              'Home',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 8,
                                color: Color(0xFFA8A6A7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 1, 29.7, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(13.1, 0, 13.3, 1),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10.9,
                                    height: 20,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_10_x2.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.9,
                                    height: 20,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_49_x2.svg',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              'Reservations',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 8,
                                color: Color(0xFFA8A6A7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 30.4, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0.1, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                      'assets/images/image_2.png',
                                    ),
                                  ),
                                ),
                                child: Container(
                                  width: 21.6,
                                  height: 22,
                                ),
                              ),
                            ),
                            Text(
                              'Carbon Footprint',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 8,
                                color: Color(0xFF222222),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 1, 32.1, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(5.8, 0, 5.5, 1),
                              width: 22.6,
                              height: 20,
                              child: SizedBox(
                                width: 22.6,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/vectors/vector_19_x2.svg',
                                ),
                              ),
                            ),
                            Text(
                              'Favorites',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 8,
                                color: Color(0xFFA8A6A7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0, 1, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(3.9, 0, 3.1, 1),
                              child: SizedBox(
                                width: 17.5,
                                height: 20,
                                child: SvgPicture.asset(
                                  'assets/vectors/iconuser_1_x2.svg',
                                ),
                              ),
                            ),
                            Text(
                              'Profile',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 8,
                                color: Color(0xFFA8A6A7),
                              ),
                            ),
                          ],
                        ),
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