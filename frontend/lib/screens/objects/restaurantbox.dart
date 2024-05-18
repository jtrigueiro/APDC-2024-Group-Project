import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantsContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RestaurantItem(
            imagePath: 'assets/images/restaurant_1.png',
            restaurantName: 'Restaurante Verde - Almada',
          ),
          RestaurantItem(
            imagePath: 'assets/images/restaurant_2.png',
            restaurantName: 'Restaurante Vermelho - Algueirão Nem Martins',
          ),
          RestaurantItem(
            imagePath: 'assets/images/restaurant_3.png',
            restaurantName: 'Restaurante Azul - Quinta do Conde',
          ),
          RestaurantItem(
            imagePath: 'assets/images/restaurant_4.jpeg',
            restaurantName: 'Restautante Amarelo - Tapadas das Mercês',
          ),
          RestaurantItem(
            imagePath: 'assets/images/restaurant_5.jpeg',
            restaurantName: 'Zoomarine Restaurante - Algarve',
          ),
        ],
      ),
    );
  }
}

class RestaurantItem extends StatelessWidget {
  final String imagePath;
  final String restaurantName;

  const RestaurantItem({
    required this.imagePath,
    required this.restaurantName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFFFFFFFF)),
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(imagePath),
                  ),
                ),
                child: Container(
                  width: 400,
                  height: 150,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text(
                restaurantName,
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF222222),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
