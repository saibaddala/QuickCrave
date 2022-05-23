import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/cart_managing_controller.dart';
import 'package:foodart/backend/controllers/popular_product_controller.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/expandable_text_widget.dart';
import 'package:foodart/reusable_widgets/name_review_geographics_widget.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:get/get.dart';
import '../backend/app_constants.dart';
import '../utilities/route_helper.dart';

class PopularFoodDetailScreen extends StatelessWidget {
  final int pageIndex;
  final String page;
  const PopularFoodDetailScreen(
      {Key? key, required this.pageIndex, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productmodel = Get.find<PopularProductController>()
        .popularProductListgetter[pageIndex];
    var controller = Get.find<CartManagingController>();
    controller.checkQuantity(productmodel);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: Dimensions.height350,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(AppConstants.baseUrl +
                      AppConstants.uploadUrl +
                      productmodel.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: Dimensions.height25,
            left: Dimensions.width15,
            right: Dimensions.width15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (page == "cartpage") {
                      Get.toNamed(RouteHelper.getCartPage());
                    } else {
                      Get.toNamed(RouteHelper.getMainPage());
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius20,
                      ),
                    ),
                    height: Dimensions.height30,
                    width: Dimensions.width30,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: Dimensions.iconSize20,
                    ),
                  ),
                ),
                GetBuilder<CartManagingController>(
                  builder: ((popularController) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.cartPageRoute);
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFfcf4e4),
                              borderRadius: BorderRadius.circular(
                                Dimensions.radius20,
                              ),
                            ),
                            height: Dimensions.height30,
                            width: Dimensions.width30,
                            child: Icon(
                              Icons.shopping_cart_outlined,
                              size: Dimensions.iconSize20,
                            ),
                          ),
                          popularController.totalItems >= 1
                              ? Positioned(
                                  right: 3,
                                  top: 2,
                                  child: Container(
                                    height: Dimensions.height15,
                                    width: Dimensions.width15,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        Dimensions.radius10,
                                      ),
                                      color: AppColors.mainColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        popularController.totalItems.toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Dimensions.fontSize10,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: Dimensions.height350 - 20,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  Dimensions.radius20,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameAndReviewAndGeographicsWidget(
                    popularProduct: productmodel,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.width15,
                      top: Dimensions.height30,
                      bottom: Dimensions.height10,
                    ),
                    child: const BigText(text: "Introduce"),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableTextWidget(
                        text: productmodel.description!,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
          left: Dimensions.width25,
          right: Dimensions.width25,
        ),
        height: Dimensions.height100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Dimensions.radius20,
          ),
          color: AppColors.buttonBackgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<CartManagingController>(builder: (controller) {
              return Container(
                height: Dimensions.height50,
                width: Dimensions.width100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    Dimensions.radius15,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (() {
                          controller.setQuantity(false);
                        }),
                        child: const Icon(
                          Icons.remove,
                          color: AppColors.signColor,
                        ),
                      ),
                      BigText(
                        text: controller.total.toString(),
                      ),
                      GestureDetector(
                        onTap: (() {
                          controller.setQuantity(true);
                        }),
                        child: const Icon(
                          Icons.add,
                          color: AppColors.signColor,
                        ),
                      )
                    ]),
              );
            }),
            GestureDetector(
              onTap: () {
                controller.addItem(productmodel);
              },
              child: Container(
                alignment: Alignment.center,
                height: Dimensions.height50,
                width: Dimensions.width180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color: AppColors.mainColor,
                ),
                child: BigText(
                  text: "₹${productmodel.price}|Add to cart",
                  textColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
