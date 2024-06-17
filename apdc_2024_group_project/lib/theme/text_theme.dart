import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextThemeApp {
  TextThemeApp._();

  static TextTheme LightTextTheme =  TextTheme(
    //logo
    headlineLarge: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 40, color:  Color.fromARGB(255, 182, 141, 64), decoration: TextDecoration.underline,
      decorationColor:   Color.fromARGB(255, 182, 141, 64),
      decorationThickness: 2,
    ),

    titleLarge:  GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w600,
      fontSize: 30, color:  Color.fromARGB(255, 182, 141, 64),),

    titleMedium:  GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w600,
      fontSize: 20, color:  Color.fromARGB(255, 182, 141, 64),),

    //cards carrousel
    displaySmall: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.bold,
      fontSize: 15, color:  Color.fromARGB(255, 39, 65, 58),),

    bodySmall: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
      fontSize: 13, color:  Color.fromARGB(255, 208, 182, 136),
    ),



  );

  static TextTheme DarkTextTheme =  TextTheme(
    headlineLarge: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontSize: 40, color:  Color.fromARGB(255, 182, 141, 64), decoration: TextDecoration.underline,
      decorationColor:   Color.fromARGB(255, 182, 141, 64),
      decorationThickness: 2,
    ),

    titleLarge:  GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w600,
      fontSize: 30, color:  Color.fromARGB(255, 182, 141, 64),),

    //cards carrousel
    displaySmall: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.bold,
      fontSize: 15, color: Color.fromARGB(255, 39, 65, 58),),

    bodySmall: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic,
      fontSize: 13, color:  Color.fromARGB(255, 208, 182, 136),
    ),
  );

}