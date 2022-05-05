import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/auth_controller.dart';
import 'package:foodart/backend/controllers/cart_controller.dart';
import 'package:foodart/backend/controllers/popular_product_controller.dart';
import 'package:foodart/backend/controllers/recommended_product_controller.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/image_and_text_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:get/get.dart';
import '../backend/app_constants.dart';
import '../utilities/route_helper.dart';
import '../utilities/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: Dimensions.width15,
            right: Dimensions.width15,
            top: Dimensions.height40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getMainPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius20)),
                    height: Dimensions.height40,
                    width: Dimensions.width40,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: Dimensions.iconSize20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.width20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getMainPage());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                    ),
                    height: Dimensions.height40,
                    width: Dimensions.width40,
                    child: Center(
                      child: Icon(
                        Icons.home_outlined,
                        size: Dimensions.iconSize20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                  ),
                  height: Dimensions.height40,
                  width: Dimensions.width40,
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: Dimensions.iconSize20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
          left: Dimensions.width10,
          right: Dimensions.width10,
          top: Dimensions.height100,
          bottom: 0,
          child: GetBuilder<CartController>(
            builder: (controller) {
              return controller.getItems().isNotEmpty
                  ? MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: ListView.builder(
                        itemCount: controller.getItems().length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin: EdgeInsets.only(
                                left: Dimensions.width5,
                                right: Dimensions.width10,
                                top: Dimensions.height10),
                            height: Dimensions.height100,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    var popularIndex =
                                        Get.find<PopularProductController>()
                                            .popularProductListgetter
                                            .indexOf(controller
                                                .getItems()[index]
                                                .product!);
                                    if (popularIndex >= 0) {
                                      Get.toNamed(
                                          RouteHelper.getPopularFoodPage(
                                              popularIndex, "cartpage"));
                                    } else {
                                      var recommendedIndex = Get.find<
                                              RecommendedProductController>()
                                          .recommendedProductListgetter
                                          .indexOf(controller
                                              .getItems()[index]
                                              .product!);
                                      if (recommendedIndex < 0) {
                                        Get.snackbar("Item Preview",
                                            "Sorry,the review of this item is not available",
                                            backgroundColor:
                                                AppColors.mainColor,
                                            colorText: Colors.white);
                                      } else {
                                        Get.toNamed(
                                            RouteHelper.getRecommendedFoodPage(
                                                recommendedIndex, "cartpage"));
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: Dimensions.height100,
                                    width: Dimensions.width100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.radius10),
                                      image: DecorationImage(
                                        image: NetworkImage(AppConstants
                                                .baseUrl +
                                            AppConstants.uploadUrl +
                                            controller.getItems()[index].img!),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: Dimensions.width10,
                                      top: Dimensions.height10,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          text: controller
                                              .getItems()[index]
                                              .name!,
                                        ),
                                        const SmallText(text: "Spicy"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                              text: "₹" +
                                                  controller
                                                      .getItems()[index]
                                                      .price!
                                                      .toString(),
                                              textColor: Colors.redAccent,
                                            ),
                                            Container(
                                              height: Dimensions.height30,
                                              width: Dimensions.width100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions.radius15),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (() {
                                                        controller
                                                            .addItemToCart(
                                                                controller
                                                                    .getItems()[
                                                                        index]
                                                                    .product!,
                                                                -1);
                                                        controller.update();
                                                      }),
                                                      child: const Icon(
                                                        Icons.remove,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    ),
                                                    BigText(
                                                        text: controller
                                                            .getItems()[index]
                                                            .quantity
                                                            .toString()),
                                                    GestureDetector(
                                                      onTap: (() {
                                                        controller
                                                            .addItemToCart(
                                                                controller
                                                                    .getItems()[
                                                                        index]
                                                                    .product!,
                                                                1);
                                                        controller.update();
                                                      }),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color:
                                                            AppColors.signColor,
                                                      ),
                                                    )
                                                  ]),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                    )
                  : const ImageAndTextWidget(
                      textToDisplay: "Ooops,Your Cart is Empty",
                      imagePath: "assets/images/empty_cart.png",
                    );
            },
          ),
        ),
      ]),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: Dimensions.width25, right: Dimensions.width25),
        height: Dimensions.height100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: AppColors.buttonBackgroundColor,
        ),
        child: GetBuilder<CartController>(builder: (controller) {
          return controller.getItems().isNotEmpty
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: Dimensions.height50,
                      width: Dimensions.width100,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        color: Colors.white,
                      ),
                      child: Center(
                          child: BigText(
                              text: "₹" + controller.totalAmount.toString())),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Get.find<AuthController>().isuserLoggedIn()) {
                          controller.addItemsToCartHistoryList();
                        } else {
                          Get.toNamed(RouteHelper.signInpageRoute);
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: Dimensions.height50,
                        width: Dimensions.width180,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius15),
                          color: AppColors.mainColor,
                        ),
                        child: const BigText(
                          text: "CheckOut",
                          textColor: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              : Container();
        }),
      ),
    );
  }
}
