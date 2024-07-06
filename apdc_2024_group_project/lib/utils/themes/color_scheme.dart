import 'package:flutter/material.dart';

class ColorAppTheme {
  ColorAppTheme._(); //to avoid creation instances

  static const lightAppColorTheme =   ColorScheme.light(
    brightness: Brightness.light,
    background: Color.fromARGB(255, 245, 245, 245),
    onBackground:  Color.fromARGB(255, 0, 36, 0),

    primary: Color.fromARGB(255, 122, 143, 122),
    onPrimary: Color.fromARGB(255, 227, 230, 227),

    error: Color.fromARGB(255, 177, 45, 30),
    onError: Color.fromARGB(255, 234, 232, 232),

    secondary:  Color.fromARGB(255, 0, 36, 0),

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