import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElButtonThemeApp {
  ElButtonThemeApp._(); //to avoid creation instances

  static final LightElButtonTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      //alignment: Alignment.topCenter,
      backgroundColor: Color.fromARGB(255, 182, 141, 64),
      foregroundColor: Color.fromARGB(255, 228, 199, 151),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      textStyle: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w600,
        fontSize: 20 ),
      fixedSize: Size(120, 40),
    ),
  );

  static final DarkElButtonTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 182, 141, 64),
      foregroundColor: Color.fromARGB(255, 18, 38, 32),
      disabledBackgroundColor: Colors.grey[800],
      disabledForegroundColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.symmetric(vertical: 18),
      textStyle: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.normal,
          fontSize: 15),
    ),
  );


}