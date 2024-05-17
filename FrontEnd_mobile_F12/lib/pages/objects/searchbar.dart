import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Stack(
        children: [
          Positioned(
            top: 35,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFFA8A6A7)),
                borderRadius: BorderRadius.circular(5),
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
                width: 400,
                height: 43,
              ),
            ),
          ),
          SizedBox(
            height: 226,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 45, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: SizedBox(
                      width: 251,
                      child: Text(
                        'Search for Restaurants',
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: Color(0xFF34A853),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: SvgPicture.asset(
                        'assets/vectors/search_icon_x2.svg',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
