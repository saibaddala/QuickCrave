import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodart/reusable_widgets/account_detail_row_widget.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';

import '../utilities/colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.mainColor,
        title: const Center(
          child: BigText(
            text: "Profile",
            textSize: 30,
            textColor: Colors.white,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 15),
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                  child: Column(
                children: const [
                  CustomIconWidget(
                    icon: Icons.person,
                    iconSize: 75,
                    containerSize: 150,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  AccountDetailRowWidget(
                      icon: Icons.person,
                      fieldText: "Bunty",
                      containerbackgroundColor: Colors.lightBlueAccent),
                  SizedBox(
                    height: 15,
                  ),
                  AccountDetailRowWidget(
                      icon: Icons.call,
                      fieldText: "9177149548",
                      containerbackgroundColor: Colors.green),
                  SizedBox(
                    height: 15,
                  ),
                  AccountDetailRowWidget(
                      icon: Icons.email,
                      fieldText: "saibaddala172@gmail.com",
                      containerbackgroundColor: Colors.redAccent),
                  SizedBox(
                    height: 15,
                  ),
                  AccountDetailRowWidget(
                      icon: Icons.location_city,
                      fieldText: "Tirupati",
                      containerbackgroundColor: Colors.blueGrey),
                  SizedBox(
                    height: 15,
                  ),
                  AccountDetailRowWidget(
                      icon: Icons.message,
                      fieldText: "Sai",
                      containerbackgroundColor: Colors.amberAccent),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
