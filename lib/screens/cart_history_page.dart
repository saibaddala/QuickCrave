import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:get/get.dart';
import '../backend/controllers/cart_controller.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          decoration: const BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20))),
          padding: const EdgeInsets.only(top: 40),
          width: double.maxFinite,
          height: 100,
          child: Stack(children: const [
            Positioned(
              left: 280 / 2,
              top: 25,
              child: BigText(
                text: "Cart History",
                textColor: Colors.white,
                textSize: 30,
              ),
            ),
            Positioned(
              right: 20,
              top: 25,
              child: Icon(
                Icons.shopping_cart_outlined,
                color: Colors.white,
              ),
            )
          ]),
        ),
        MediaQuery.removePadding(
            context: context,
            child: Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 25, right: 25, top: 5),
              child: ListView(
                children: [
                  for (int i = 0; i < 5; i++)
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BigText(text: "22/05/2021"),
                          Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(
                              6,
                              (index) => Container(
                                margin: const EdgeInsets.only(left: 10),
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/images/food0.png")),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ))),
      ]),
    );
  }
}
