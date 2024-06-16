import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextThemeApp {
  TextThemeApp._();

  static TextTheme LightTextTheme =  TextTheme(
    bodyMedium: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontSize: 15, color:  Color.fromARGB(255, 39, 65, 58),),

    titleMedium: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontSize: 20, color:  Color.fromARGB(255, 39, 65, 58),),

    titleLarge:  GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w600,
      fontSize: 30, color:  Color.fromARGB(255, 209, 173, 98),),

    displayLarge: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.bold,
      fontSize: 40, color:  Color.fromARGB(255, 39, 65, 58),),

    displayMedium: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w600,
      fontSize: 40, color:  Color.fromARGB(255, 39, 65, 58),),

    //logo
    headlineLarge: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 40, color:  Color.fromARGB(255, 182, 141, 64), decoration: TextDecoration.underline,
      decorationColor:   Color.fromARGB(255, 182, 141, 64),
      decorationThickness: 2,
    ),

    bodySmall: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
      fontSize: 13, color:  Color.fromARGB(255, 208, 182, 136),
    ),

  );

  static TextTheme DarkTextTheme =  TextTheme(
    bodyMedium: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontSize: 15, color: Colors.white,),

    titleMedium: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontSize: 20, color: Colors.white,),

    displayLarge: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontSize: 50, color: Colors.white,),

  );

}