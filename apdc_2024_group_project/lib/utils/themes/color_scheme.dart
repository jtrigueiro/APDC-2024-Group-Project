import 'package:flutter/material.dart';

class ColorAppTheme {
  ColorAppTheme._(); //to avoid creation instances

  static const lightAppColorTheme = ColorScheme.light(
    brightness: Brightness.light,
    background: Color.fromARGB(255, 245, 245, 245),
    onBackground: Color.fromARGB(255, 0, 36, 0),

    primary: Color.fromARGB(255, 61, 130, 20),
    onPrimary: Color.fromARGB(255, 227, 230, 227),

    error: Color.fromARGB(255, 177, 45, 30),
    onError: Color.fromARGB(255, 234, 232, 232),

    secondary: Color.fromARGB(255, 209, 123, 48),

    tertiary: Colors.white,
    inversePrimary: Color.fromARGB(
        255, 230, 228, 228), //para o form em promoCodes todo: rever
  );

  static const darkAppColorTheme = ColorScheme.dark(
    brightness: Brightness.dark,
    background: Color.fromARGB(255, 18, 38, 32),

    primary: Color.fromARGB(255, 61, 130, 20),
    onPrimary: Color.fromARGB(255, 227, 230, 227),


    error: Color.fromARGB(255, 223, 45, 51),
    onError: Color.fromARGB(255, 234, 232, 232),

    secondary: Color.fromARGB(255, 209, 123, 48),
    tertiary: Color.fromARGB(255, 18, 38, 32) ,


    inversePrimary: Color.fromARGB(
        255, 126, 126, 126), //para o form em promoCodes todo: rever
  );
}
