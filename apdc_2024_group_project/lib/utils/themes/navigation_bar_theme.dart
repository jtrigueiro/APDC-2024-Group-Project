import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class AppNavBarTheme {
  AppNavBarTheme._(); //to avoid creation instances

  static final lightAppNavBarTheme = BottomNavigationBarThemeData(
    backgroundColor: ColorAppTheme.lightAppColorTheme.background,
    selectedItemColor: ColorAppTheme.lightAppColorTheme.onBackground,
    unselectedItemColor: ColorAppTheme.lightAppColorTheme.primary,
  );

  static const darkAppNavBarTheme =  BottomNavigationBarThemeData(
    backgroundColor:  Color.fromARGB(255, 32, 67, 55),
    selectedItemColor: Color.fromARGB(255, 133, 98, 22),
    unselectedItemColor: Color.fromARGB(255, 250, 248, 223),
  );


}