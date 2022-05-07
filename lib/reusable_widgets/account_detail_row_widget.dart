import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';

import '../utilities/dimensions.dart';

class AccountDetailRowWidget extends StatelessWidget {
  final IconData icon;
  final String fieldText;
  final Color iconColor;
  final Color containerbackgroundColor;
  final bool overflowRequired;

  const AccountDetailRowWidget(
      {Key? key,
      required this.icon,
      required this.fieldText,
      this.iconColor = Colors.white,
      required this.containerbackgroundColor,
      this.overflowRequired = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(
        Dimensions.height10,
      ),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 5,
            offset: const Offset(0, 5),
          )
        ],
        borderRadius: BorderRadius.circular(
          Dimensions.radius20,
        ),
        color: Colors.white,
      ),
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: Dimensions.width15,
        right: Dimensions.width10,
        top: Dimensions.height5,
        bottom: Dimensions.height5,
      ),
      child: Row(
        children: [
          CustomIconWidget(
            icon: icon,
            iconColor: iconColor,
            containerBackgroundColor: containerbackgroundColor,
            iconSize: Dimensions.iconSize25,
            containerSize: Dimensions.height50,
          ),
          SizedBox(
            width: Dimensions.height20,
          ),
          BigText(
            text: fieldText,
            textColor: Colors.black,
            textSize: Dimensions.fontSize20,
            wantOverflow: true,
          )
        ],
      ),
    );
  }
}
