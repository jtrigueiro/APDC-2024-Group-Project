import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextThemeApp {
  TextThemeApp._();

  static TextTheme appTextTheme = TextTheme(

    //used
    titleLarge: GoogleFonts.getFont(
      'Open Sans',
      fontWeight: FontWeight.w500,
      fontSize: 25,
    ),

    //used
    titleMedium: GoogleFonts.getFont(
      'Open Sans',
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),
    //used back office
    titleSmall: GoogleFonts.getFont(
      'Open Sans',
      fontWeight: FontWeight.w400,
      fontSize: 15,
    ),

    //used
    displayMedium: GoogleFonts.getFont(
      'Open Sans',
      fontWeight: FontWeight.normal,
      fontSize: 20,
    ),

    //used
    labelSmall: GoogleFonts.getFont(
      'Open Sans',
      fontWeight: FontWeight.normal,
      fontSize: 10,
    ),

    displaySmall: GoogleFonts.getFont(
      'Open Sans',
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),

    bodyMedium: GoogleFonts.getFont(
      'Open Sans',
      fontWeight: FontWeight.bold,
      fontSize: 15,
    ),

    //used
    bodySmall: GoogleFonts.getFont(
        'Open Sans',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
      fontSize: 12
    ),
  );

}
