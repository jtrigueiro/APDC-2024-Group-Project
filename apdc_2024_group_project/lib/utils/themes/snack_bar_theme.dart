import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:adc_group_project/utils/themes/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSnackBarTheme {
  AppSnackBarTheme._(); //to avoid creation instances

  static final lightAppSnackBarTheme = SnackBarThemeData(
    backgroundColor: ColorAppTheme.lightAppColorTheme.secondary,
    elevation: 0.5,

  );

}
