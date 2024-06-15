
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {

  static Text texts(String text, double size) {
    return Text(text,
      style: GoogleFonts.getFont(
        'Nunito',
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: const Color(0xFF000000),),
    );
  }

  static TextFormField textForms(TextEditingController controller, text,
      String textNoValue) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: '$text*',
          labelStyle: const TextStyle(
              fontStyle: FontStyle.italic, color: Colors.black),
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.green),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          )
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return textNoValue;
        }
        return null;
      },
    );
  }
}