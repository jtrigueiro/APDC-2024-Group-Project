import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInformationScreenfilled extends StatelessWidget {
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 41),
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
                            'assets/vectors/vector_52_x2.svg',
                          ),
                        ),
                      ),
                      Text(
                        'Personal Information',
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
              margin: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(43),
                ),
                child: Container(
                  width: 86,
                  height: 86,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 11),
              child: Text(
                'User Name',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Color(0xFF222222),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(1, 0, 0, 65),
              child: Text(
                'useremail@gmail.com',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: Color(0xFF222222),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 1, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(18.1, 0, 18.1, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'First name*',
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
                      padding: EdgeInsets.fromLTRB(13.2, 18, 13.2, 4),
                      child: Text(
                        'First name',
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
              margin: EdgeInsets.fromLTRB(0, 0, 1, 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20.4, 0, 20.4, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Last name*',
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
                      padding: EdgeInsets.fromLTRB(13.3, 11, 13.3, 11),
                      child: Text(
                        'Last name',
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
              margin: EdgeInsets.fromLTRB(1, 0, 0, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(20.3, 0, 20.3, 0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email*',
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
                      padding: EdgeInsets.fromLTRB(12.2, 11, 12.2, 11),
                      child: Text(
                        'useremail@gmail.com',
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
              margin: EdgeInsets.fromLTRB(0, 0, 1, 9),
              child: Container(
                padding: EdgeInsets.fromLTRB(19.3, 0, 19.3, 47),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Text(
                      'Phone number*',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Color(0xFF222222),
                      ),
                    ),
                    Positioned(
                      left: -19.3,
                      right: -19.3,
                      bottom: -47,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x80D9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          width: 359,
                          height: 49,
                          padding: EdgeInsets.fromLTRB(13, 16, 13, 6),
                          child: Text(
                            '925788778',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 1, 37),
              child: Container(
                padding: EdgeInsets.fromLTRB(23, 0, 23, 47),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Text(
                      'Password',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w300,
                        fontSize: 14,
                        color: Color(0xFF222222),
                      ),
                    ),
                    Positioned(
                      left: -23,
                      right: -23,
                      bottom: -47,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x80D9D9D9),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: SizedBox(
                          width: 359,
                          height: 49,
                          child: Container(
                            padding: EdgeInsets.fromLTRB(13.1, 6, 9, 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 13.5, 5),
                                  child: SizedBox(
                                    width: 222.4,
                                    child: Text(
                                      '*******',
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
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xFFA8A6A7)),
                                    borderRadius: BorderRadius.circular(15),
                                    color: Color(0xFFFFFFFF),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(0, 2),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(14.7, 4, 14.7, 4),
                                    child: Text(
                                      'Change',
                                      style: GoogleFonts.getFont(
                                        'Nunito',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                        color: Color(0xFF222222),
                                      ),
                                    ),
                                  ),
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
            ),
            Container(
              margin: EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
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
                      'Save',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFF000000),
                      ),
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