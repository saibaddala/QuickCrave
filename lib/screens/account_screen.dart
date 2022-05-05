import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/account_detail_row_widget.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';
import '../utilities/colors.dart';
import '../utilities/dimensions.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: Dimensions.height150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(Dimensions.radius40),
                bottomRight: Radius.circular(Dimensions.radius40)),
            color: AppColors.mainColor,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(top: Dimensions.height15),
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: Dimensions.radius80,
                          backgroundImage:
                              const AssetImage("assets/images/sai.png"),
                        ),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        const AccountDetailRowWidget(
                            icon: Icons.person,
                            fieldText: "Bunty",
                            containerbackgroundColor: AppColors.mainColor),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        const AccountDetailRowWidget(
                            icon: Icons.call,
                            fieldText: "9177149548",
                            containerbackgroundColor: AppColors.mainColor),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        const AccountDetailRowWidget(
                            icon: Icons.email,
                            fieldText: "saibaddala172@gmail.com",
                            containerbackgroundColor: AppColors.mainColor),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        const AccountDetailRowWidget(
                            icon: Icons.location_city,
                            fieldText: "Tirupati",
                            containerbackgroundColor: AppColors.mainColor),
                        SizedBox(
                          height: Dimensions.height15,
                        ),
                        const AccountDetailRowWidget(
                            icon: Icons.message,
                            fieldText: "Sai",
                            containerbackgroundColor: AppColors.mainColor),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
