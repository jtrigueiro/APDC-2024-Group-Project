import 'package:flutter/material.dart';

class ColorAppTheme {
  ColorAppTheme._(); //to avoid creation instances

  static const lightAppColorTheme =   ColorScheme.light(
    background: Color.fromARGB(255, 250, 248, 223),
    brightness: Brightness.light,
    error: Color.fromARGB(255, 158, 54, 60),
    primary: Color.fromARGB(255, 182, 141, 64),
    secondary: Color.fromARGB(255, 117, 85, 18),
    tertiary: Color.fromARGB(255, 208, 182, 136)

  );

  static const darkAppColorTheme =  ColorScheme.dark(
      background: Color.fromARGB(255, 250, 248, 223),
      brightness: Brightness.dark,
      error: Color.fromARGB(255, 158, 54, 60),
      primary: Color.fromARGB(255, 18, 38, 32),
      secondary: Color.fromARGB(255, 182, 141, 64),
      tertiary: Color.fromARGB(255, 182, 141, 64)

  );

}