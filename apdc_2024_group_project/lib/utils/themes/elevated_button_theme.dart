import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ElButtonThemeApp {
  ElButtonThemeApp._(); //to avoid creation instances

  static final lightElButtonTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color.fromARGB(255, 39, 88, 42),
      foregroundColor: ColorAppTheme.lightAppColorTheme.background,
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      textStyle: GoogleFonts.getFont('Open Sans', fontWeight: FontWeight.w500,
        fontSize: 15 ),
     padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
    ),
  );

  static final DarkElButtonTheme =  ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      //alignment: Alignment.topCenter,
      backgroundColor: Color.fromARGB(255, 182, 141, 64),
      foregroundColor: Color.fromARGB(255, 228, 199, 151),
      disabledBackgroundColor: Colors.grey,
      disabledForegroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      textStyle: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.w600,
          fontSize: 19 ),
    ),
  );


}