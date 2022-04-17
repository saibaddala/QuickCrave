import 'package:flutter/material.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SmallText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final double textHeight;
  final TextOverflow textOverflow;
  final bool wantOverflow;
  const SmallText({
    Key? key,
    required this.text,
    this.textColor = AppColors.textColor,
    this.textSize = 15,
    this.textHeight = 1.8,
    this.textOverflow = TextOverflow.ellipsis,
    this.wantOverflow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: textColor,
        fontSize: textSize == 15 ? Dimensions.fontSize15 : textSize,
        height: textHeight,
      ),
      overflow: wantOverflow ? textOverflow : null,
    );
  }
}
