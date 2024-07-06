import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextThemeApp {
  TextThemeApp._();

  static TextTheme lightTextTheme = TextTheme(

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

    //cards carrousel
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

    bodySmall: GoogleFonts.getFont(
        'Open Sans',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
      fontSize: 13
    ),
  );

  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 40,
      color: const Color.fromARGB(255, 182, 141, 64),
      decoration: TextDecoration.underline,
      decorationColor: const Color.fromARGB(255, 182, 141, 64),
      decorationThickness: 2,
    ),

    //appbar
    titleLarge: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.w600,
      fontSize:26,
      color: const Color.fromARGB(255, 182, 141, 64),
    ),

    titleMedium: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      color: const Color.fromARGB(255, 182, 141, 64),
    ),
    //cards carrousel
    displaySmall: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.bold,
      fontSize: 15,
      color: const Color.fromARGB(255, 39, 65, 58),
    ),

    bodyMedium: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 15,
      color: const Color.fromARGB(255, 215, 184, 126),
    ),

    bodySmall: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
      fontSize: 13,
      color: const Color.fromARGB(255, 208, 182, 136),
    ),
  );
}
