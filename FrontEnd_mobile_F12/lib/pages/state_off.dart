import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_app/utils.dart';
import 'package:google_fonts/google_fonts.dart';

class StateOff extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFB7B0B0)),
        borderRadius: BorderRadius.circular(100),
        color: Color(0xFF827F7F),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(3, 3, 3, 2),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(6.5),
          ),
          child: Container(
            width: 13,
            height: 13,
          ),
        ),
      ),
    );
  }
}