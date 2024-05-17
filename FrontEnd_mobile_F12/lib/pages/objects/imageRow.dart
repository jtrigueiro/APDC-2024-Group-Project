import 'package:flutter/material.dart';

class ImageRow extends StatelessWidget {
  final List<Map<String, String>> categoryImages;

  ImageRow({required this.categoryImages});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryImages.map((categoryImage) {
          String imagePath = categoryImage['imagePath']!;
          String category = categoryImage['category']!;
          return Container(
            width: 60, // Defina a largura desejada do container
            height: 60, // Defina a altura desejada do container
            margin: EdgeInsets.fromLTRB(0, 0, 30, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  10), // Ajuste o raio conforme necessário
              color: Color(0xFFFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 2),
                  blurRadius: 6,
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding:
                      EdgeInsets.all(10), // Adicione um espaçamento interno
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        100), // Ajuste o raio conforme necessário
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity, // Ocupar todo o espaço disponível
                      height:
                          double.infinity, // Ocupar todo o espaço disponível
                    ),
                  ),
                ),
                Positioned(
                  bottom:
                      0, // Ajuste a distância do texto para a parte inferior
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 1),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 9, 9, 9),
                        fontSize:
                            11, // Ajuste o tamanho da fonte conforme necessário
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
