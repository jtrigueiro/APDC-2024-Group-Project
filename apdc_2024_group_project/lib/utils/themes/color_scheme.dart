import 'package:flutter/material.dart';

class ColorAppTheme {
  ColorAppTheme._(); //to avoid creation instances

  static const lightAppColorTheme =   ColorScheme.light(
    background: Color.fromARGB(255, 250, 248, 223),
    brightness: Brightness.light,
    error: Color.fromARGB(255, 158, 54, 60),
    onError: Color.fromARGB(255, 234, 232, 232),
    primary: Color.fromARGB(255, 182, 141, 64),
    secondary: Color.fromARGB(255, 117, 85, 18),
    tertiary: Color.fromARGB(255, 208, 182, 136),
    inversePrimary: Color.fromARGB(255, 230, 228, 228),//para o form em promoCodes todo: rever

  );

  static const darkAppColorTheme =  ColorScheme.dark(
      background: Color.fromARGB(255, 250, 248, 223),
      brightness: Brightness.dark,
      error: Color.fromARGB(255, 158, 54, 60),
      onError: Color.fromARGB(255, 234, 232, 232),
      primary: Color.fromARGB(255, 18, 38, 32),
      secondary: Color.fromARGB(255, 182, 141, 64),
      tertiary: Color.fromARGB(255, 208, 182, 136),

      inversePrimary: Color.fromARGB(255, 126, 126, 126), //para o form em promoCodes todo: rever

  );

}