import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

//const int topMargin = 10;

const textInputDecoration = InputDecoration(
  labelStyle: TextStyle(fontStyle: FontStyle.italic, color: Color(0xFFA8A6A7)),
);

Text texts(String text, double size) {
  return Text(
    text,
    style: GoogleFonts.getFont(
      'Nunito',
      fontWeight: FontWeight.normal,
      fontSize: size,
      color: const Color(0xFF000000),
    ),
  );
}

TextFormField textForms(
    TextEditingController controller, text, String textNoValue) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration().copyWith(
      labelText: '$text',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return textNoValue;
      }
      return null;
    },
  );

}

TextFormField textFormsPhone(
    TextEditingController controller, text, String textNoValue) {
  return TextFormField(
    keyboardType: TextInputType.number,
    inputFormatters:  <TextInputFormatter> [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      LengthLimitingTextInputFormatter(15),
      FilteringTextInputFormatter.digitsOnly,
    ],
    controller: controller,
    decoration: InputDecoration().copyWith(
      labelText: '$text',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return textNoValue;
      }
      return null;
    },
  );
}

TextFormField textFormsDouble(
    TextEditingController controller, text, String textNoValue) {
  return TextFormField(
   keyboardType: TextInputType.numberWithOptions(signed: false, decimal: true),
    controller: controller,
    decoration: InputDecoration().copyWith(
      labelText: '$text',
    ),
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly
    ],
    validator: (value) {
      //final RegExp regex = RegExp("^[0-9]");
      if (value == null || value.isEmpty ) {
        return textNoValue;
      }

      return null;
    },
  );
}

TextFormField textFormsObscure(
    TextEditingController controller, text, String textNoValue) {
  return TextFormField(
    obscureText: true,
    controller: controller,
    decoration: InputDecoration().copyWith(
      labelText: '$text',
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return textNoValue;
      }
      return null;
    },
  );
}

TextFormField textForms1(
    TextEditingController controller, text, String textNoValue) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(
        labelText: '$text*',
        labelStyle:
            const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
        border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(10)),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        )),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return textNoValue;
      }
      return null;
    },
  );
}

ElevatedButton cancelButton(BuildContext context) {
  return ElevatedButton(
    onPressed: () {
      Navigator.pop(context);
    },
    style: ElevatedButton.styleFrom(
      backgroundColor:  Theme.of(context).colorScheme.error,
      foregroundColor: Theme.of(context).colorScheme.onError,
    ),
    child: const Text('Cancel'),
  );
}

SizedBox spaceBetweenColumns() {
  return SizedBox(height: 10);
}

SizedBox customSpaceBetweenColumns(double size) {
  return SizedBox(height: size);
}
