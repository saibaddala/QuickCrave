import 'package:flutter/material.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class IconAndText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color iconColor;
  final Color textColor;
  final double iconSize;
  final double textSize;

  const IconAndText(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.iconColor,
      required this.textColor,
      this.iconSize = 25,
      this.textSize = 15})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconData,
          color: iconColor,
          size: iconSize == 25 ? Dimensions.iconSize25 : iconSize,
        ),
        SizedBox(
          width: Dimensions.width5,
        ),
        Text(text,
            style: GoogleFonts.roboto(
              color: textColor,
              fontSize: textSize == 15 ? Dimensions.fontSize15 : textSize,
            ))
      ],
    );
  }
}
