import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRestaurantScreennoRestaurant extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
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
                            'assets/vectors/vector_7_x2.svg',
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
              margin: EdgeInsets.fromLTRB(0, 0, 1, 140),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text( 
                  "You don’t have a restaurant yet\n",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Color(0xFF000000),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(19.3, 0, 19.3, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Restaurant name*',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0x80D9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(17.3, 12, 17.3, 10),
                      child: Text(
                        'Restaurant name',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(17.1, 0, 17.1, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Phone Number*',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0x80D9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 11, 16, 11),
                      child: Text(
                        'Phone Number',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 261),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(19.4, 0, 19.4, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Location*',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Color(0xFF222222),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0x80D9D9D9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(17.3, 11, 24.6, 11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 13.5, 0),
                            child: SizedBox(
                              width: 287.2,
                              child: Text(
                                'Location',
                                style: GoogleFonts.getFont(
                                  'Nunito',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20,
                                  color: Color(0xFF222222),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 3),
                            child: SizedBox(
                              width: 16.4,
                              height: 20,
                              child: SvgPicture.asset(
                                'assets/vectors/iconmap_pin_x2.svg',
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
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0x2B34A853)),
                borderRadius: BorderRadius.circular(15),
                color: Color(0x4034A853),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 2),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Container(
                width: 127,
                padding: EdgeInsets.fromLTRB(1, 3, 0, 3),
                child: Text(
                  'Send',
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: Color(0xFF000000),
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