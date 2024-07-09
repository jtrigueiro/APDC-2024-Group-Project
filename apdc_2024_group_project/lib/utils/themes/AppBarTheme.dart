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
    titleTextStyle: TextThemeApp.appTextTheme.titleMedium!
        .copyWith(color: ColorAppTheme.lightAppColorTheme.onBackground),
    elevation: 0.5,
    shadowColor: const Color.fromARGB(255, 122, 143, 122),
  );

  static final darkAppBarTheme = AppBarTheme(
    centerTitle: true,
    backgroundColor: ColorAppTheme.lightAppColorTheme.primary,
    foregroundColor: const Color.fromARGB(255, 0, 36, 0),
    scrolledUnderElevation: 2,
    iconTheme: const IconThemeData(color: Color.fromARGB(255, 0, 36, 0)),
    titleTextStyle: TextThemeApp.appTextTheme.titleMedium!
        .copyWith(color: ColorAppTheme.lightAppColorTheme.onBackground),
    elevation: 0.5,
    shadowColor: const Color.fromARGB(255, 122, 143, 122),
  );
}
