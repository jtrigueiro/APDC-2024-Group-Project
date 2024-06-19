import 'package:flutter/material.dart';

class InputTheme {
  InputTheme._(); //to avoid creation instances

  static final lightInputTheme =  InputDecorationTheme(
    labelStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 215, 184, 126)),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 215, 184, 126)),
      ),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 65, 12, 18)),
        borderRadius: BorderRadius.circular(10),
    ),
  );


  static final DarkInputTheme =  InputDecorationTheme(
    labelStyle: const TextStyle(fontStyle: FontStyle.italic, color: Color.fromARGB(255, 182, 141, 64)),
    border: OutlineInputBorder(
        borderSide: const BorderSide(color: Color.fromARGB(255, 182, 141, 64)),
        borderRadius: BorderRadius.circular(10)),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Color.fromARGB(255, 182, 141, 64)),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: Color.fromARGB(255, 128, 41, 52)),
      borderRadius: BorderRadius.circular(10),
    ),
  );


}