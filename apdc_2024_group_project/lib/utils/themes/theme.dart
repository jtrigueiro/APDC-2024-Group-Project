import 'package:adc_group_project/utils/themes/AppTabBarTheme.dart';
import 'package:adc_group_project/utils/themes/InputTheme.dart';
import 'package:adc_group_project/utils/themes/card_theme.dart';
import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:adc_group_project/utils/themes/elevated_button_theme.dart';
import 'package:adc_group_project/utils/themes/snack_bar_theme.dart';
import 'package:adc_group_project/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';

import 'AppBarTheme.dart';
import 'navigation_bar_theme.dart';

class AppThemeStyle {
  AppThemeStyle._();

  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: const Color.fromARGB(255, 122, 143, 122),
      scaffoldBackgroundColor: ColorAppTheme.lightAppColorTheme.background,
      textTheme: TextThemeApp.appTextTheme,
      elevatedButtonTheme: ElButtonThemeApp.lightElButtonTheme,
      inputDecorationTheme: InputTheme.lightInputTheme,
      appBarTheme: AppBarAppTheme.lightAppBarTheme,
      bottomNavigationBarTheme: AppNavBarTheme.lightAppNavBarTheme,
      cardTheme: AppCardTheme.lightCardTheme,
      colorScheme: ColorAppTheme.lightAppColorTheme,
      snackBarTheme: AppSnackBarTheme.appSnackBarTheme,
      tabBarTheme: AppTabBarTheme.lightAppBarTheme);

  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: const Color.fromARGB(255, 122, 143, 122),
      scaffoldBackgroundColor: ColorAppTheme.darkAppColorTheme.background,
      textTheme: TextThemeApp.appTextTheme,
      elevatedButtonTheme: ElButtonThemeApp.darkElButtonTheme,
      inputDecorationTheme: InputTheme.darkInputTheme,
      appBarTheme: AppBarAppTheme.darkAppBarTheme,
      bottomNavigationBarTheme: AppNavBarTheme.darkAppNavBarTheme,
      cardTheme: AppCardTheme.darkCardTheme,
      colorScheme: ColorAppTheme.darkAppColorTheme,
      snackBarTheme: AppSnackBarTheme.appSnackBarTheme,
      tabBarTheme: AppTabBarTheme.darkAppBarTheme);
}
