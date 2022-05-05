import 'package:flutter/material.dart';
import 'package:foodart/utilities/dimensions.dart';
import '../utilities/colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final TextEditingController textController;
  final String hintText;
  final IconData iconData;
  const CustomTextFieldWidget(
      {Key? key,
      required this.textController,
      required this.hintText,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius40),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 7,
                offset: const Offset(1, 10))
          ]),
      margin:
          EdgeInsets.only(left: Dimensions.width7, right: Dimensions.width7),
      child: TextField(
        controller: textController,
        autofocus: false,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Icon(
            iconData,
            color: AppColors.yellowColor,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius40),
              borderSide:
                  const BorderSide(width: 1, color: AppColors.mainColor)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius40),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius40),
            borderSide: const BorderSide(
              color: Colors.purple,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
