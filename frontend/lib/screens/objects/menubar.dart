import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  final String? iconPath; // Mantido para aceitar caminho do ícone
  final IconData? iconData; // Adicionado para aceitar IconData (opcional)
  final String label;
  final Color labelColor;
  final double iconWidth;
  final double iconHeight;
  final EdgeInsets iconMargin;
  final VoidCallback onTap;

  const MenuItem({
    this.iconPath, // Mantido para aceitar caminho do ícone
    this.iconData, // Adicionado para aceitar IconData (opcional)
    required this.label,
    required this.labelColor,
    required this.iconWidth,
    required this.iconHeight,
    required this.iconMargin,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: iconMargin,
              child: iconData != null // Verifique se IconData foi fornecido
                  ? Icon(
                      iconData, // Use o IconData fornecido
                      size: iconWidth, // Ajuste conforme necessário
                      color: labelColor, // Use a mesma cor do rótulo
                    )
                  : (iconPath !=
                          null // Verifique se o caminho do ícone foi fornecido
                      ? iconPath!.endsWith('.svg') // Verifique se é um SVG
                          ? SvgPicture.asset(
                              iconPath!,
                              width: iconWidth,
                              height: iconHeight,
                            )
                          : Image.asset(
                              iconPath!,
                              width: iconWidth,
                              height: iconHeight,
                            )
                      : Container()), // Renderize uma caixa vazia se nenhum ícone for fornecido
            ),
            SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.nunito(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: labelColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
