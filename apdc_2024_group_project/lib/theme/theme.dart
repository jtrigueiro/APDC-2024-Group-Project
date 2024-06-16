import 'package:adc_group_project/theme/InputTheme.dart';
import 'package:adc_group_project/theme/elevated_button_theme.dart';
import 'package:adc_group_project/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'AppBarTheme.dart';
import 'navigation_bar_theme.dart';

class AppThemeStyle {

  AppThemeStyle._();

  static ThemeData lightTheme =  ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: Color.fromARGB(255, 182, 141, 64),
    scaffoldBackgroundColor: Color.fromARGB(255, 250, 248, 223),
    textTheme: TextThemeApp.LightTextTheme,
    elevatedButtonTheme: ElButtonThemeApp.LightElButtonTheme,
    inputDecorationTheme: InputTheme.LightInputTheme,
    appBarTheme: AppBarAppTheme.LightAppBarTheme,
    bottomNavigationBarTheme: AppNavBarTheme.lightAppNavBarTheme

  );

  static ThemeData darkTheme =  ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primaryColor: Color.fromARGB(255, 18, 38, 32),
  scaffoldBackgroundColor: Color.fromARGB(255, 18, 38, 32),
  textTheme: TextThemeApp.DarkTextTheme,
      elevatedButtonTheme: ElButtonThemeApp.DarkElButtonTheme,
      inputDecorationTheme: InputTheme.DarkInputTheme,
      appBarTheme: AppBarAppTheme.DarkAppBarTheme,
      bottomNavigationBarTheme: AppNavBarTheme.darkAppNavBarTheme
  );


}
