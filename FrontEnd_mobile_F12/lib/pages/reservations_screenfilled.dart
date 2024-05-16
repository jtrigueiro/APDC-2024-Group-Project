import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ReservationsScreenfilled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 64, 0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(5, 0, 4, 579),
              child: Stack(
                children: [
                  Positioned(
                    left: -13,
                    right: -27.1,
                    top: -11.5,
                    bottom: -22,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: 351,
                        height: 113,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 2),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/vectors/dishbox_x2.svg',
                        ),
                      ),
                    ),
                  ),
            Container(
                    padding: EdgeInsets.fromLTRB(13, 11.5, 27.1, 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 3.5, 18, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                  'assets/images/restaurant_1.png',
                                ),
                              ),
                            ),
                            child: Container(
                              width: 95,
                              height: 76,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 21.1, 5),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(5.7, 0, 5.7, 34.5),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'Piemonte Torino',
                                          style: GoogleFonts.getFont(
                                            'Nunito',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 16,
                                            color: Color(0xFF222222),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0, 1, 5.1, 5),
                                          width: 12,
                                          height: 12,
                                          child: SizedBox(
                                            width: 12,
                                            height: 12,
                                            child: SvgPicture.asset(
                                              'assets/vectors/vector_41_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0, 0, 9.6, 0),
                                          child: Text(
                                            '9 Oct 2024 ',
                                            style: GoogleFonts.getFont(
                                              'Nunito',
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13,
                                              color: Color(0xFF222222),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(0, 1, 2.8, 1.8),
                                          child: SizedBox(
                                            width: 15.2,
                                            height: 15.2,
                                            child: SvgPicture.asset(
                                              'assets/vectors/iconclock_outline_x2.svg',
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '20:30',
                                          style: GoogleFonts.getFont(
                                            'Nunito',
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 13,
                                            color: Color(0xFF222222),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 6.1,
                                top: 20,
                                child: SizedBox(
                                  height: 18,
                                  child: Text(
                                    'Italiana',
                                    style: GoogleFonts.getFont(
                                      'Nunito',
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 6,
                                bottom: 20,
                                child: SizedBox(
                                  height: 18,
                                  child: Text(
                                    'Active',
                                    style: GoogleFonts.getFont(
                                      'Nunito',
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 13,
                                      color: Color(0xFF34A853),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 59.5, 3.8, 7.7),
                          width: 10.7,
                          height: 12.3,
                          child: SizedBox(
                            width: 10.7,
                            height: 12.3,
                            child: SvgPicture.asset(
                              'assets/vectors/iconuser_7_x2.svg',
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(4.8, 0, 2.8, 34.5),
                                child: Text(
                                  '􀈑',
                                  style: GoogleFonts.getFont(
                                    'Roboto Condensed',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    height: 1.3,
                                    color: Color(0xFFFF3B30),
                                  ),
                                ),
                              ),
                              Text(
                                '2p.',
                                style: GoogleFonts.getFont(
                                  'Nunito',
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13,
                                  color: Color(0xFF222222),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                                  'assets/vectors/iconhome_5_x2.svg',
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
                                      'assets/vectors/vector_38_x2.svg',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10.9,
                                    height: 20,
                                    child: SvgPicture.asset(
                                      'assets/vectors/vector_13_x2.svg',
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
                                color: Color(0xFF222222),
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
                                color: Color(0xFFA8A6A7),
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
                                  'assets/vectors/vector_29_x2.svg',
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
                                  'assets/vectors/iconuser_2_x2.svg',
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