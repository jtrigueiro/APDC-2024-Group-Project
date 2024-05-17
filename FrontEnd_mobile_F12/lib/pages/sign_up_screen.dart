import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
    const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(28, 98, 27.3, 144.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0.3, 0, 0, 49.2),
              child: Text(
                'Sign Up',
                style: GoogleFonts.getFont(
                  'Nunito',
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(3, 0, 3.7, 67.3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0.1, 0, 0, 135),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        'Fist creat your account',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFFA8A6A7),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8.2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Full name',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFFA8A6A7),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0.3, 7.2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFA8A6A7),
                      ),
                      child: Container(
                        width: 297.7,
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8.2),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Email',
                        style: GoogleFonts.getFont(
                          'Nunito',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: Color(0xFFA8A6A7),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0.3, 7.2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFA8A6A7),
                      ),
                      child: Container(
                        width: 297.7,
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 11, 0),
                          child: SizedBox(
                            width: 268.4,
                            child: Text(
                              'Password',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFFA8A6A7),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 3.2, 0, 3.1),
                          child: SizedBox(
                            width: 18.5,
                            height: 15.7,
                            child: SvgPicture.asset(
                              'assets/vectors/eye_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0.3, 7.2),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFA8A6A7),
                      ),
                      child: Container(
                        width: 297.7,
                        height: 1,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 8.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 11, 0),
                          child: SizedBox(
                            width: 268.4,
                            child: Text(
                              'Confirm your password',
                              style: GoogleFonts.getFont(
                                'Nunito',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Color(0xFFA8A6A7),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 3.2, 0, 3.1),
                          child: SizedBox(
                            width: 18.5,
                            height: 15.7,
                            child: SvgPicture.asset(
                              'assets/vectors/eye_1_x2.svg',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0.3, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFA8A6A7),
                      ),
                      child: Container(
                        width: 297.7,
                        height: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 22.7),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF222222),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 4.5, 0.7, 3.8),
                  child: Text(
                    'SIGN UP',
                    style: GoogleFonts.getFont(
                      'Nunito',
                      fontWeight: FontWeight.w400,
                      fontSize: 22,
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.3, 0, 0, 0),
              child: RichText(
                text: TextSpan(
                  text: 'Already have an account? ',
                  style: GoogleFonts.getFont(
                    'Nunito',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xFF000000),
                  ),
                  children: [
                    TextSpan(
                      text: ' Login',
                      style: GoogleFonts.getFont(
                        'Nunito',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        height: 1.3,
                        color: Color(0xFF34A853),
                        decorationColor: Color(0xFF34A853),
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