import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpAndSupportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 30.5),
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
                                'assets/vectors/vector_26_x2.svg',
                              ),
                            ),
                          ),
                          Text(
                            'Help and Support',
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
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 40.5),
                  child: Text(
                    'Need Assistance?',
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xFF222222),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(8, 0, 7, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0x4D34A853),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(24, 21, 0, 21.8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                            width: 64.2,
                            height: 64.2,
                            child: SizedBox(
                              width: 64.2,
                              height: 64.2,
                              child: SvgPicture.asset(
                                'assets/vectors/vector_11_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 11.2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                                  child: Text(
                                    'Contact us',
                                    style: GoogleFonts.getFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 25,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(6.9, 0, 7.9, 0),
                                  child: Text(
                                    'Send us an email',
                                    style: GoogleFonts.getFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w200,
                                      fontSize: 14,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 86.5,
            child: SizedBox(
              height: 27,
              child: Text(
                'Need Assistance?',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color(0xFF222222),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}