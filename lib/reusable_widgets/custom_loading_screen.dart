import 'package:flutter/material.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Container(
        height: Dimensions.height50,
        width: Dimensions.width50,
        decoration: const BoxDecoration(
            shape: BoxShape.circle, color: AppColors.mainColor),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        ),
      )),
    );
  }
}
