import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuItem extends StatelessWidget {
  final String iconPath;
  final String label;
  final Color labelColor;
  final double iconWidth;
  final double iconHeight;
  final EdgeInsets iconMargin;
  final VoidCallback onTap;

  const MenuItem({
    required this.iconPath,
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
              child: iconPath.endsWith('.svg')
                  ? SvgPicture.asset(
                      iconPath,
                      width: iconWidth,
                      height: iconHeight,
                    )
                  : Image.asset(
                      iconPath,
                      width: iconWidth,
                      height: iconHeight,
                    ),
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
