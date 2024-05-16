import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRestaurantScreenwaitingForApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 240),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 284),
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
                            'assets/vectors/vector_20_x2.svg',
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
              margin: EdgeInsets.fromLTRB(0, 0, 1, 82),
              child: Text(
                "You already made a request, wait for approval, you will be contacted by our team soon.'",
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 1, 0),
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
                width: 207,
                padding: EdgeInsets.fromLTRB(0, 14, 0, 14),
                child: Text(
                  'Help & Support',
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Color(0xFF07561C),
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