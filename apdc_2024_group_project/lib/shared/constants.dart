import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Color(0xFFA8A6A7)),
);

Text texts(String text, double size)  {
  return Text(text,
    style: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.normal,
      fontSize: size,
      color: const Color(0xFF000000),),
  );
}


TextFormField textForms(TextEditingController controller, text, String textNoValue) {
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

ElevatedButton cancelButton (BuildContext context) {
 return ElevatedButton (
  onPressed: () {
      Navigator.pop(context);
  },
  style: ElevatedButton.styleFrom(

    backgroundColor: Colors.green[100],
    foregroundColor: Colors.green[900],
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
  ),
  child: const Text('Cancel'),
  );

}

SizedBox spaceBetweenColumns()
{
  return SizedBox(height: 10);
}

SizedBox CustomSpaceBetweenColumns(double size)
{
  return SizedBox(height: size);
}