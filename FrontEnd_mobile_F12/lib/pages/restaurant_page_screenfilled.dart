import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantPageScreenfilled extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 3),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: SizedBox(
              width: 361,
              child: Container(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 12),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0x3B34A853),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          padding: EdgeInsets.fromLTRB(11, 13, 10, 6),
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
                                      margin: EdgeInsets.fromLTRB(7, 0, 10, 15.5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 3.7, 0, 8.3),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(0, 0, 13, 0),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.fromLTRB(0.3, 0, 0.3, 4),
                                                        child: Align(
                                                          alignment: Alignment.topLeft,
                                                          child: Container(
                                                            width: 10.8,
                                                            height: 21.6,
                                                            child: SizedBox(
                                                              width: 10.8,
                                                              height: 21.6,
                                                              child: SvgPicture.asset(
                                                                'assets/vectors/vector_42_x2.svg',
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Piemonte Torino - Almada',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 16,
                                                          color: Color(0xFF222222),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(0, 32.3, 0, 5.2),
                                                  child: SizedBox(
                                                    width: 20,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.fromLTRB(0, 0, 4, 0),
                                                          child: SizedBox(
                                                            width: 8,
                                                            height: 10,
                                                            child: SvgPicture.asset(
                                                              'assets/vectors/iconeuro_1_x2.svg',
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 8,
                                                          height: 10,
                                                          child: SvgPicture.asset(
                                                            'assets/vectors/iconeuro_x2.svg',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                                child: SizedBox(
                                                  width: 37,
                                                  height: 38,
                                                  child: SvgPicture.asset(
                                                    'assets/vectors/star_62_x2.svg',
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(7.8, 0, 7.8, 0),
                                                child: Text(
                                                  '4.5',
                                                  style: GoogleFonts.getFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15,
                                                    color: Color(0xFF222222),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 0, 4),
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
                                          width: 340,
                                          height: 156,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(15, 0, 6.2, 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0, 0, 8.4, 0),
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
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0, 8.5, 11.4, 3.5),
                                                child: RichText(
                                                  text: TextSpan(
                                                    text: '0.3 ',
                                                    style: GoogleFonts.getFont(
                                                      'Nunito',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 15,
                                                      color: Color(0xFF222222),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'CO2e*',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 10,
                                                          height: 1.3,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.fromLTRB(0, 8, 0, 3),
                                                child: SizedBox(
                                                  width: 22,
                                                  height: 21,
                                                  child: SvgPicture.asset(
                                                    'assets/vectors/iconleaf_x2.svg',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 8, 0, 3),
                                            width: 21.8,
                                            height: 21,
                                            child: SizedBox(
                                              width: 21.8,
                                              height: 21,
                                              child: SvgPicture.asset(
                                                'assets/vectors/vector_31_x2.svg',
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(9.1, 0, 9.1, 0),
                                      child: Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '*average per dish',
                                          style: GoogleFonts.getFont(
                                            'Nunito',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 11,
                                            color: Color(0xFF222222),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                left: 7.1,
                                top: 50.5,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 31, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 9.4, 0),
                            child: SizedBox(
                              width: 21.6,
                              height: 25,
                              child: SvgPicture.asset(
                                'assets/vectors/iconecology_book_x2.svg',
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 1.5, 0, 1.5),
                            child: Text(
                              'Menu',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
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
          Container(
            padding: EdgeInsets.fromLTRB(0, 365, 0, 177),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(2, 0),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.fromLTRB(0, 13, 1, 12.9),
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
                        width: 207,
                        padding: EdgeInsets.fromLTRB(0, 14, 0, 9.1),
                        child: Text(
                          'Reserve',
                          style: GoogleFonts.getFont(
                            'Nunito',
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                            color: Color(0xFF07561C),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 4,
                  right: 5,
                  bottom: 0,
                  child: SizedBox(
                    width: 351,
                    height: 620,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                  padding: EdgeInsets.fromLTRB(11, 3, 0, 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/las_1.jpeg',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 111,
                                          height: 89,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 8.5, 0, 12.5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Lasagna da vida',
                                                  style: GoogleFonts.getFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 16,
                                                    color: Color(0xFF222222),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0.3, 0, 0, 13.5),
                                              child: Text(
                                                'egg, cheese, meat, milk, tomato sauce, onions',
                                                style: GoogleFonts.getFont(
                                                  'Nunito',
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 8,
                                                  color: Color(0xFF222222),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(8.3, 0, 8.3, 0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: GoogleFonts.getFont(
                                                      'Nunito',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xFF222222),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'CO2e',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 11,
                                                          height: 1.3,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ': ',
                                                      ),
                                                      TextSpan(
                                                        text: '0.1',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 15,
                                                          height: 1.3,
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
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                  padding: EdgeInsets.fromLTRB(11, 3, 0, 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/las_11.jpeg',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 111,
                                          height: 89,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 8.5, 0, 12.5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Pasta Torino',
                                                  style: GoogleFonts.getFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 16,
                                                    color: Color(0xFF222222),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0.3, 0, 0, 13.5),
                                              child: Text(
                                                'egg, cheese, meat, milk, tomato sauce, onions',
                                                style: GoogleFonts.getFont(
                                                  'Nunito',
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 8,
                                                  color: Color(0xFF222222),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(3.8, 0, 3.8, 0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: GoogleFonts.getFont(
                                                      'Nunito',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xFF222222),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'CO2e',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 11,
                                                          height: 1.3,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ': ',
                                                      ),
                                                      TextSpan(
                                                        text: '0.02',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 15,
                                                          height: 1.3,
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
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                  padding: EdgeInsets.fromLTRB(11, 3, 0, 3),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                              'assets/images/las_12.jpeg',
                                            ),
                                          ),
                                        ),
                                        child: Container(
                                          width: 111,
                                          height: 89,
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(0, 8.5, 0, 12.5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  'Vegano Piemonte',
                                                  style: GoogleFonts.getFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 16,
                                                    color: Color(0xFF222222),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(0.3, 0, 0, 13.5),
                                              child: Text(
                                                'egg, cheese, meat, milk, tomato sauce, onions',
                                                style: GoogleFonts.getFont(
                                                  'Nunito',
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 8,
                                                  color: Color(0xFF222222),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.fromLTRB(8.3, 0, 8.3, 0),
                                              child: Align(
                                                alignment: Alignment.topLeft,
                                                child: RichText(
                                                  text: TextSpan(
                                                    style: GoogleFonts.getFont(
                                                      'Nunito',
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 12,
                                                      color: Color(0xFF222222),
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: 'CO2e',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w400,
                                                          fontSize: 11,
                                                          height: 1.3,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ': ',
                                                      ),
                                                      TextSpan(
                                                        text: '0.2',
                                                        style: GoogleFonts.getFont(
                                                          'Nunito',
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: 15,
                                                          height: 1.3,
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
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 210,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 351,
                              height: 95,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(11, 3, 0, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/las_1.jpeg',
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        width: 111,
                                        height: 89,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 8.5, 0, 12.5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Lasagna da vida',
                                                style: GoogleFonts.getFont(
                                                  'Nunito',
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16,
                                                  color: Color(0xFF222222),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0.3, 0, 0, 13.5),
                                            child: Text(
                                              'egg, cheese, meat, milk, tomato sauce, onions',
                                              style: GoogleFonts.getFont(
                                                'Nunito',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 8,
                                                color: Color(0xFF222222),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(8.3, 0, 8.3, 0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.getFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color(0xFF222222),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'CO2e',
                                                      style: GoogleFonts.getFont(
                                                        'Nunito',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 11,
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ': ',
                                                    ),
                                                    TextSpan(
                                                      text: '0.1',
                                                      style: GoogleFonts.getFont(
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15,
                                                        height: 1.3,
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 105,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 351,
                              height: 95,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(11, 3, 0, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/las_11.jpeg',
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        width: 111,
                                        height: 89,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 8.5, 0, 12.5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Pasta Torino',
                                                style: GoogleFonts.getFont(
                                                  'Nunito',
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16,
                                                  color: Color(0xFF222222),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0.3, 0, 0, 13.5),
                                            child: Text(
                                              'egg, cheese, meat, milk, tomato sauce, onions',
                                              style: GoogleFonts.getFont(
                                                'Nunito',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 8,
                                                color: Color(0xFF222222),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(3.8, 0, 3.8, 0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.getFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color(0xFF222222),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'CO2e',
                                                      style: GoogleFonts.getFont(
                                                        'Nunito',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 11,
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ': ',
                                                    ),
                                                    TextSpan(
                                                      text: '0.02',
                                                      style: GoogleFonts.getFont(
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15,
                                                        height: 1.3,
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFFFFFFF),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x40000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 351,
                              height: 95,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(11, 3, 0, 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: AssetImage(
                                            'assets/images/las_12.jpeg',
                                          ),
                                        ),
                                      ),
                                      child: Container(
                                        width: 111,
                                        height: 89,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 8.5, 0, 12.5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0, 0, 0, 1.5),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Vegano Piemonte',
                                                style: GoogleFonts.getFont(
                                                  'Nunito',
                                                  fontWeight: FontWeight.w200,
                                                  fontSize: 16,
                                                  color: Color(0xFF222222),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(0.3, 0, 0, 13.5),
                                            child: Text(
                                              'egg, cheese, meat, milk, tomato sauce, onions',
                                              style: GoogleFonts.getFont(
                                                'Nunito',
                                                fontWeight: FontWeight.w200,
                                                fontSize: 8,
                                                color: Color(0xFF222222),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(8.3, 0, 8.3, 0),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: RichText(
                                                text: TextSpan(
                                                  style: GoogleFonts.getFont(
                                                    'Nunito',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Color(0xFF222222),
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: 'CO2e',
                                                      style: GoogleFonts.getFont(
                                                        'Nunito',
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 11,
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ': ',
                                                    ),
                                                    TextSpan(
                                                      text: '0.2',
                                                      style: GoogleFonts.getFont(
                                                        'Nunito',
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 15,
                                                        height: 1.3,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}