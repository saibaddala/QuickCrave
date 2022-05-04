import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';
import 'package:foodart/utilities/colors.dart';

class AccountDetailRowWidget extends StatelessWidget {
  final IconData icon;
  final String fieldText;
  final Color iconColor;
  final Color containerbackgroundColor;

  const AccountDetailRowWidget(
      {Key? key,
      required this.icon,
      required this.fieldText,
      this.iconColor = Colors.white,
      required this.containerbackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          blurRadius: 5,
          offset: Offset(0, 5),
        )
      ], borderRadius: BorderRadius.circular(20), color: Colors.white),
      width: double.maxFinite,
      padding: EdgeInsets.only(left: 15, right: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          CustomIconWidget(
            icon: icon,
            iconColor: iconColor,
            containerBackgroundColor: containerbackgroundColor,
            iconSize: 30,
            containerSize: 50,
          ),
          SizedBox(
            width: 20,
          ),
          BigText(
            text: fieldText,
            textColor: Colors.black,
          )
        ],
      ),
    );
  }
}
