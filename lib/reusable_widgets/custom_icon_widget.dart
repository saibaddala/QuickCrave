import 'package:flutter/material.dart';
import 'package:foodart/utilities/colors.dart';

class CustomIconWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color containerBackgroundColor;
  final double iconSize;
  final double containerSize;

  const CustomIconWidget(
      {Key? key,
      required this.icon,
      this.iconColor = Colors.white,
      this.containerBackgroundColor = AppColors.mainColor,
      this.iconSize = 40,
      this.containerSize = 40})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: containerSize,
      width: containerSize,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: containerBackgroundColor),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
