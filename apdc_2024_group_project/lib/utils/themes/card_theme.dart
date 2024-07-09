import 'package:flutter/material.dart';

class AppCardTheme {
  AppCardTheme._(); //to avoid creation instances

  static const lightCardTheme = CardTheme(
    color: Color.fromARGB(255, 255, 255, 255),
    shadowColor: Colors.black,
    elevation: 3,
    clipBehavior: Clip.hardEdge,
    surfaceTintColor: Colors.white //idk
  );

  static const darkCardTheme = CardTheme(
    color: Color.fromARGB(255, 32, 67, 55),
    shadowColor: Colors.black,
    elevation: 3,
    clipBehavior: Clip.hardEdge,
      surfaceTintColor: Colors.white //idk
  );

}