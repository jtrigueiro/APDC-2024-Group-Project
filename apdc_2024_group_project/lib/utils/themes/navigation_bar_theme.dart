import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class AppNavBarTheme {
  AppNavBarTheme._(); //to avoid creation instances

  static final lightAppNavBarTheme = BottomNavigationBarThemeData(
    backgroundColor: ColorAppTheme.lightAppColorTheme.background,
    selectedItemColor: ColorAppTheme.lightAppColorTheme.primary,
    unselectedItemColor: const Color.fromARGB(255, 188, 185, 185)
  );

  static final darkAppNavBarTheme =  BottomNavigationBarThemeData(
      backgroundColor: ColorAppTheme.darkAppColorTheme.background,
      selectedItemColor: ColorAppTheme.darkAppColorTheme.primary,
      unselectedItemColor: const Color.fromARGB(255, 104, 104, 104)
  );


}