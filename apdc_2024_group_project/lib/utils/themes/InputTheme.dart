import 'package:adc_group_project/utils/themes/color_scheme.dart';
import 'package:flutter/material.dart';

class InputTheme {
  InputTheme._(); //to avoid creation instances

  static final lightInputTheme = InputDecorationTheme(
    labelStyle:
        const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
    border: OutlineInputBorder(
        borderSide: BorderSide(color: ColorAppTheme.lightAppColorTheme.primary),
        borderRadius: BorderRadius.circular(50)),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorAppTheme.lightAppColorTheme.primary),
        borderRadius: BorderRadius.circular(20)),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorAppTheme.lightAppColorTheme.error),
      borderRadius: BorderRadius.circular(20),
    ),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorAppTheme.lightAppColorTheme.primary),
        borderRadius: BorderRadius.circular(20)),
  );

  static final darkInputTheme = InputDecorationTheme(
      labelStyle:
          const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
      border: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorAppTheme.lightAppColorTheme.primary),
          borderRadius: BorderRadius.circular(50)),
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorAppTheme.lightAppColorTheme.primary),
          borderRadius: BorderRadius.circular(20)),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorAppTheme.lightAppColorTheme.error),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorAppTheme.lightAppColorTheme.primary),
          borderRadius: BorderRadius.circular(20)));
}
