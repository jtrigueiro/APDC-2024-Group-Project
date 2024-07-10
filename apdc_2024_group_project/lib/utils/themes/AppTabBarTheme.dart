import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:adc_group_project/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTabBarTheme {
  AppTabBarTheme._(); //to avoid creation instances

  static const lightAppBarTheme = TabBarTheme(
    unselectedLabelColor: Color.fromARGB(255, 188, 185, 185),
  );

  static const darkAppBarTheme = TabBarTheme(
    unselectedLabelColor: Color.fromARGB(255, 188, 185, 185),
    indicatorColor: Colors.black,
    labelColor: Colors.black,
    dividerHeight: 2,
    dividerColor: Colors.black

  );
}
