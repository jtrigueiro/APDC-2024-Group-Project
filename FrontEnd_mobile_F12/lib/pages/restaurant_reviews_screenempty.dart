import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantReviewsScreenempty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(1, 0, 0, 287),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 38.5),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x3B34A853),
                ),
                child: SizedBox(
                  width: 360,
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
                              'assets/vectors/vector_54_x2.svg',
                            ),
                          ),
                        ),
                        Text(
                          'Reviews',
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
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 1, 135.5),
              child: Text(
                'No reviews yet',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 36,
                  color: Color(0xFF222222),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(23, 0, 24, 149),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      child: SvgPicture.asset(
                        'assets/vectors/star_11_x2.svg',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      child: SvgPicture.asset(
                        'assets/vectors/star_21_x2.svg',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 6, 0),
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      child: SvgPicture.asset(
                        'assets/vectors/star_31_x2.svg',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                    child: SizedBox(
                      width: 58,
                      height: 58,
                      child: SvgPicture.asset(
                        'assets/vectors/star_4_x2.svg',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 58,
                    height: 58,
                    child: SvgPicture.asset(
                      'assets/vectors/star_51_x2.svg',
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'You don’t have any reviews yet',
              style: GoogleFonts.getFont(
                'Nunito',
                fontWeight: FontWeight.w300,
                fontSize: 20,
                color: Color(0xFF222222),
              ),
            ),
          ],
        ),
      ),
    );
  }
}