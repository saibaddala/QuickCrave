import 'package:flutter/material.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class BigText extends StatelessWidget {
  final String text;
  final Color textColor;
  final double textSize;
  final TextOverflow textOverflow;
  final bool wantOverflow;
  const BigText({
    Key? key,
    required this.text,
    this.textColor = AppColors.mainBlackColor,
    this.textSize = 20,
    this.textOverflow = TextOverflow.ellipsis,
    this.wantOverflow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        color: textColor,
        fontSize: textSize == 20 ? Dimensions.fontSize20 : textSize,
      ),
      overflow: wantOverflow ? textOverflow : null,
    );
  }
}
