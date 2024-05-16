import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 41, 0, 0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(8.2, 0, 26, 109),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 19, 39.2, 12),
                          child: Text(
                            'User Name',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w400,
                              fontSize: 40,
                              color: Color(0xFF222222),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(43),
                            ),
                            child: Container(
                              height: 86,
                            ),
                          ),
                        ),
                      ],
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
                            margin: EdgeInsets.fromLTRB(0, 6, 12.1, 5),
                            child: SizedBox(
                              width: 24,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/vectors/iconfile_text_x2.svg',
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
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 11),
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
                                'assets/vectors/icongift_1_x2.svg',
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
                    margin: EdgeInsets.fromLTRB(31, 0, 31, 63),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 15.2, 5),
                            child: SizedBox(
                              width: 19.1,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/vectors/iconaward_x2.svg',
                              ),
                            ),
                          ),
                          Text(
                            'Achievements',
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
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 11),
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
                                'assets/vectors/iconsettings_1_x2.svg',
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
                  Container(
                    margin: EdgeInsets.fromLTRB(26, 0, 26, 219),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 9.5, 5),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/vectors/iconhelp_circle_x2.svg',
                              ),
                            ),
                          ),
                          Text(
                            'Help and Support',
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
                                        'assets/vectors/iconhome_x2.svg',
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
                                            'assets/vectors/vector_35_x2.svg',
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.9,
                                          height: 20,
                                          child: SvgPicture.asset(
                                            'assets/vectors/vector_18_x2.svg',
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
                                        'assets/vectors/vector_17_x2.svg',
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
                                        'assets/vectors/iconuser_8_x2.svg',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Profile',
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 26,
              right: 28.1,
              top: 184,
              child: SizedBox(
                width: 305.9,
                height: 405,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 167),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 0, 5),
                            child: SizedBox(
                              width: 26.7,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/vectors/iconuser_9_x2.svg',
                              ),
                            ),
                          ),
                          Text(
                            'Personal Information',
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
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 115),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 6, 9.2, 5),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: SvgPicture.asset(
                                  'assets/vectors/group_x2.svg',
                                ),
                              ),
                            ),
                            Text(
                              'My Restaurant',
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
                    Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 6, 9.1, 5),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                'assets/vectors/iconlog_out_x2.svg',
                              ),
                            ),
                          ),
                          Text(
                            'Log Out',
                            style: GoogleFonts.getFont(
                              'Nunito',
                              fontWeight: FontWeight.w200,
                              fontSize: 30,
                              color: Color(0xFFEA4335),
                            ),
                          ),
                        ],
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