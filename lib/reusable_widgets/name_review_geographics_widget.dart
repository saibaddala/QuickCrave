import 'package:flutter/material.dart';
import 'package:foodart/backend/models/product_model.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/icon_and_text_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';

class NameAndReviewAndGeographicsWidget extends StatelessWidget {
  final double iconSize;
  final double textSize;
   ProductModel? popularProducts;
  NameAndReviewAndGeographicsWidget({
    Key? key,
    ProductModel? popularProduct,
    this.iconSize = 25,
    this.textSize = 15,
  }) : super(key: key) {
    popularProducts = popularProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.width15,
        right: Dimensions.width15,
        top: Dimensions.height15,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        BigText(text: popularProducts!=null?popularProducts!.name!:"No data"),
        SizedBox(
          height: Dimensions.height5,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        size: Dimensions.iconSize15,
                        color: AppColors.mainColor,
                      )),
            ),
            SizedBox(
              width: Dimensions.width5,
            ),
            SmallText(text: popularProducts!=null?popularProducts!.stars!.toString():"No data"),
            SizedBox(
              width: Dimensions.width10,
            ),
            const SmallText(text: "1575 comments")
          ],
        ),
        SizedBox(
          height: Dimensions.height20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(
              iconData: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
              textColor: AppColors.textColor,
              iconSize: iconSize,
              textSize: textSize,
            ),
            SizedBox(
              width: Dimensions.width5,
            ),
            IconAndText(
              iconData: Icons.location_on,
              text: "4.5km",
              iconColor: AppColors.mainColor,
              textColor: AppColors.textColor,
              iconSize: iconSize,
              textSize: textSize,
            ),
            SizedBox(
              width: Dimensions.width5,
            ),
            IconAndText(
              iconData: Icons.timer,
              text: "37min",
              iconColor: AppColors.iconColor2,
              textColor: AppColors.textColor,
              iconSize: iconSize,
              textSize: textSize,
            )
          ],
        )
      ]),
    );
  }
}
