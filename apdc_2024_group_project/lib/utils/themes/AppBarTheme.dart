import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:adc_group_project/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarAppTheme {
  AppBarAppTheme._(); //to avoid creation instances

  static final lightAppBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: const Color.fromARGB(255, 253, 253, 253),
    foregroundColor: const Color.fromARGB(255, 0, 36, 0),
    scrolledUnderElevation: 2,
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 36, 0)),
    titleTextStyle: TextThemeApp.lightTextTheme.titleLarge!.copyWith(color: ColorAppTheme.lightAppColorTheme.onBackground),
    elevation: 0.5,
    shadowColor: const Color.fromARGB(255, 122, 143, 122),

  );

  static final DarkAppBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: Color.fromARGB(255, 32, 67, 55),
    foregroundColor: Color.fromARGB(255, 182, 141, 64),
    scrolledUnderElevation: 3, //idk
    surfaceTintColor: Color.fromARGB(255, 18, 38, 32),
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextThemeApp.lightTextTheme.titleLarge,
    elevation: 2,
    shadowColor: Color.fromARGB(255, 18, 38, 32),
  );
}
