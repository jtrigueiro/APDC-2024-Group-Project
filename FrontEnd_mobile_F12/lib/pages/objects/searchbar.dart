import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_app/pages/objects/categoryRow.dart';

class SearchContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0),
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 2),
                  blurRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none, // Remover a linha ao redor
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black, // Ícone da lupa preto
                  ),
                  hintText: 'Search for Restaurants',
                  hintStyle: GoogleFonts.lato(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                style:
                    TextStyle(color: Colors.black), // Texto digitado em preto
              ),
            ),
          ),
          SizedBox(height: 20), // Espaçamento entre o TextField e o CategoryRow
          CategoryRow(),
          SizedBox(height: 20), // Espaço extra após o CategoryRow
        ],
      ),
    );
  }
}
