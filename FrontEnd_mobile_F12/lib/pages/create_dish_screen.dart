import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateDishScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: 361,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 1, 68),
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
                                  'assets/vectors/vector_14_x2.svg',
                                ),
                              ),
                            ),
                            Text(
                              'Dish Creator',
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
                    margin: EdgeInsets.fromLTRB(0, 0, 2, 19),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.3, 0, 0.3, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              ' Name*',
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
                            padding: EdgeInsets.fromLTRB(0.2, 18, 0.2, 4),
                            child: Text(
                              'Name',
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
                    margin: EdgeInsets.fromLTRB(0.5, 0, 26.7, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 110.7, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 77.5, 104),
                                  child: Text(
                                    ' Ingredients*',
                                    style: GoogleFonts.getFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
                                      color: Color(0xFF222222),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 78, 0, 0),
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color(0x40000000),
                                        offset: Offset(0, 4),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/vectors/group_2_x2.svg',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 38.9, 0, 73.3),
                          width: 21.6,
                          height: 10.8,
                          child: SizedBox(
                            width: 21.6,
                            height: 10.8,
                            child: SvgPicture.asset(
                              'assets/vectors/vector_28_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(2, 0, 0, 32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(3.1, 0, 3.1, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              ' Price*',
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
                            padding: EdgeInsets.fromLTRB(32, 11, 32, 11),
                            child: Text(
                              '€',
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
                    margin: EdgeInsets.fromLTRB(2, 0, 0, 34),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0.1, 0, 0.1, 0),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0.1, 0),
                                  child: Text(
                                    ' Footprint*',
                                    style: GoogleFonts.getFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w300,
                                      fontSize: 14,
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
                                    width: 19,
                                    height: 19,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0x80D9D9D9),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            height: 49,
                            padding: EdgeInsets.fromLTRB(29, 15, 29, 15),
                            child: Container(
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
                                width: 18,
                                height: 19,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 1, 67),
                    width: 78,
                    height: 78,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0, 4),
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/vectors/group_1_x2.svg',
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 1, 30),
                    child: Text(
                      'Add Photo',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w400,
                        fontSize: 25,
                        color: Color(0xFF000000),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(13, 0, 13, 0),
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
            Positioned(
              left: 0,
              right: 1,
              top: 230,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x80D9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  width: 359,
                  height: 49,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}