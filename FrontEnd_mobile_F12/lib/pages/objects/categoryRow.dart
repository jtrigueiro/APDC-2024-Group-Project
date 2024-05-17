import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categoryImages = [
      {'imagePath': 'assets/images/ellipse_2.png', 'category': 'Italian'},
      {'imagePath': 'assets/images/ellipse_4.png', 'category': 'Burger'},
      {'imagePath': 'assets/images/ellipse.png', 'category': 'Traditional'},
      {'imagePath': 'assets/images/las_1.jpeg', 'category': 'Sushi'},
      {'imagePath': 'assets/images/ellipse_3.png', 'category': 'Pizza'},
      {'imagePath': 'assets/images/ellipse_1.png', 'category': 'Chinese'},
      // Adicione mais categorias conforme necessário
    ];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categoryImages.map((categoryImage) {
            String imagePath = categoryImage['imagePath']!;
            String category = categoryImage['category']!;
            return Container(
              width: 70, // Largura do contêiner principal
              height: 90, // Altura do contêiner principal para incluir o texto
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFFFFFF),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x40000000),
                    offset: Offset(0, 2),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60, // Largura da imagem
                    height: 60, // Altura da imagem
                    padding:
                        EdgeInsets.all(2), // Adicione um espaçamento interno
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          30), // Ajuste o raio conforme necessário
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                  SizedBox(height: 4), // Espaçamento entre a imagem e o texto
                  Text(
                    category,
                    style: TextStyle(
                      color: Color(0xFF090909),
                      fontSize: 10, // Tamanho da fonte do texto
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
