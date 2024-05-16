import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class PromoCodesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 564),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 59),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0x3B34A853),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(18.3, 12, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 5.7, 0, 6.7),
                        width: 10.8,
                        height: 21.6,
                        child: SizedBox(
                          width: 10.8,
                          height: 21.6,
                          child: SvgPicture.asset(
                            'assets/vectors/vector_32_x2.svg',
                          ),
                        ),
                      ),
                      Text(
                        'Promo Codes',
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
              margin: EdgeInsets.fromLTRB(15, 0, 18, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 17),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 23, 0, 22),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Opacity(
                            opacity: 0.8,
                            child: Text(
                              'Name',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Color(0xFFE71010),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFD5D8DE)),
                                borderRadius: BorderRadius.circular(4),
                                color: Color(0xFFFFFFFF),
                              ),
                              child: Container(
                                width: 327,
                                height: 60,
                                padding: EdgeInsets.fromLTRB(16, 20, 16, 18),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: Text(
                                    'Promotional Code',
                                    style: GoogleFonts.getFont(
                                      'Nunito',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF323941),
                                    ),
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
                    margin: EdgeInsets.fromLTRB(3, 0, 6.9, 0),
                    child: Opacity(
                      opacity: 0.8,
                      child: Text(
                        'You can input any promotional codes here to get amazing rewards!',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xFF222222),
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
    );
  }
}