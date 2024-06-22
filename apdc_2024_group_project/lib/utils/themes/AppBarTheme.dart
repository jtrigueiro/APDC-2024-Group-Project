import 'package:adc_group_project/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarAppTheme {
  AppBarAppTheme._(); //to avoid creation instances

  static final lightAppBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 182, 141, 64),
    foregroundColor: Color.fromARGB(255, 18, 38, 32),
    scrolledUnderElevation: 3, //idk
    surfaceTintColor: Color.fromARGB(255, 182, 141, 64),
    iconTheme: IconThemeData(color: Color.fromARGB(255, 117, 85, 18)),
    titleTextStyle: TextThemeApp.LightTextTheme.titleLarge,
    elevation: 2,
    shadowColor: Color.fromARGB(255, 117, 85, 18),

  );

  static final DarkAppBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 32, 67, 55),
    foregroundColor: Color.fromARGB(255, 182, 141, 64),
    scrolledUnderElevation: 3, //idk
    surfaceTintColor: Color.fromARGB(255, 18, 38, 32),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextThemeApp.LightTextTheme.titleLarge,
    elevation: 2,
    shadowColor: Color.fromARGB(255, 18, 38, 32),
  );
}
