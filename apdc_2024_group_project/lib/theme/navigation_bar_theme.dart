import 'package:flutter/material.dart';

class AppNavBarTheme {
  AppNavBarTheme._(); //to avoid creation instances

  static const lightAppNavBarTheme = BottomNavigationBarThemeData(
    backgroundColor: Color.fromARGB(255, 215, 184, 126),
      selectedItemColor: Color.fromARGB(255, 133, 98, 22),
      unselectedItemColor: Color.fromARGB(255, 250, 248, 223),
  );

  static const darkAppNavBarTheme =  BottomNavigationBarThemeData(
    backgroundColor:  Color.fromARGB(255, 18, 38, 32),
    selectedItemColor: Color.fromARGB(255, 133, 98, 22),
    unselectedItemColor: Color.fromARGB(255, 250, 248, 223),
  );


}