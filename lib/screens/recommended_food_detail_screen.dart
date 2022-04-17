import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/expandable_text_widget.dart';
import 'package:foodart/utilities/colors.dart';

import '../utilities/dimensions.dart';

class RecommendedFoodDetailScreen extends StatelessWidget {
  const RecommendedFoodDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: Dimensions.width30,
              height: Dimensions.height30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: const Color(0xFFfcf4e4)),
              child: Icon(
                Icons.clear,
                color: AppColors.mainBlackColor,
                size: Dimensions.iconSize20,
              ),
            ),
            Container(
              width: Dimensions.width30,
              height: Dimensions.height30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: const Color(0xFFfcf4e4)),
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.mainBlackColor,
                size: Dimensions.iconSize20,
              ),
            )
          ]),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset(
              "assets/images/food0.png",
              fit: BoxFit.cover,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Dimensions.height20),
            child: Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20)),
                color: Colors.white,
              ),
              child: const Center(child: BigText(text: "Maraine tamarind")),
            ),
          ),
          expandedHeight: Dimensions.height300,
          pinned: true,
          backgroundColor: AppColors.yellowColor,
        ),
        const SliverToBoxAdapter(
          child: ExpandableTextWidget(
              text:
                  "chicken is very tasty chicken is very tasty chicken is very tastychicken is very tastychicken is very tastychicken is very tasty chicken is very tasty chicken is very tastyv  cery tastychicken is very tastychicken is very tastychicken is very tastychicken is very tastychicken is very tastychicken is very tastychicken is very tastychicken is very tastychicken is very tasty"),
        )
      ]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
        ),
        height: Dimensions.height120,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(
                  top: Dimensions.height10, bottom: Dimensions.height10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: Dimensions.width30,
                    height: Dimensions.height30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                  SizedBox(
                    width: Dimensions.width30,
                  ),
                  const BigText(text: "₹123.2"),
                  SizedBox(
                    width: Dimensions.width30,
                  ),
                  Container(
                    width: Dimensions.width30,
                    height: Dimensions.height30,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: Dimensions.width20, right: Dimensions.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: Dimensions.height50,
                    width: Dimensions.width50,
                    child: const Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: Dimensions.height50,
                    width: Dimensions.width180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: const BigText(
                      text: "₹25.6|Add to cart",
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
