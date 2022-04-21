import 'package:flutter/material.dart';
import 'package:foodart/backend/cart_controller.dart';
import 'package:foodart/backend/popular_product_controller.dart';
import 'package:foodart/backend/recommended_product_controller.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:get/get.dart';
import '../backend/app_constants.dart';
import '../route_helper.dart';
import '../utilities/dimensions.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
            left: 15,
            right: 15,
            top: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.initialRoute);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20)),
                    height: 40,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.initialRoute);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20)),
                    height: 40,
                    width: 40,
                    child: Center(
                      child: Icon(
                        Icons.home_outlined,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: 40,
                  width: 40,
                  child: Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )),
        Positioned(
            left: 10,
            right: 10,
            top: 100,
            bottom: 0,
            child: Container(
              child: GetBuilder<CartController>(
                builder: (controller) {
                  return MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        itemCount: controller.getItems().length,
                        itemBuilder: ((context, index) {
                          return Container(
                            margin:
                                EdgeInsets.only(left: 5, right: 10, top: 10),
                            height: 100,
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
                                              popularIndex,"cartpage"));
                                    } else {
                                      var recommendedIndex = Get.find<
                                              RecommendedProductController>()
                                          .RecommendedProductListgetter
                                          .indexOf(controller
                                              .getItems()[index]
                                              .product!);
                                      Get.toNamed(
                                          RouteHelper.getRecommendedFoodPage(
                                              recommendedIndex,"cartpage"));
                                    }
                                  },
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              AppConstants.baseUrl +
                                                  "/uploads/" +
                                                  controller
                                                      .getItems()[index]
                                                      .img!),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                            text: controller
                                                .getItems()[index]
                                                .name!),
                                        SmallText(text: "Spicy"),
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
                                              height: 30,
                                              width: 100,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (() {
                                                        controller.addItem(
                                                            controller
                                                                .getItems()[
                                                                    index]
                                                                .product!,
                                                            -1);
                                                        controller.update();
                                                      }),
                                                      child: Icon(
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
                                                        controller.addItem(
                                                            controller
                                                                .getItems()[
                                                                    index]
                                                                .product!,
                                                            1);
                                                        controller.update();
                                                      }),
                                                      child: Icon(
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
                        })),
                  );
                },
              ),
            ))
      ]),
       bottomNavigationBar: Container(
        padding: EdgeInsets.only(
            left: Dimensions.width25, right: Dimensions.width25),
        height: Dimensions.height100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius20),
          color: AppColors.buttonBackgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<CartController>(builder: (controller) {
              return Container(
                height: Dimensions.height50,
                width: Dimensions.width100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius15),
                  color: Colors.white,
                ),
                child: 
                      
                      Center(child: BigText(text: "₹" +controller.totalAmount.toString())),
                    
                   
              );
            }),
            GestureDetector(
              onTap: () {
              
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
                  text: "CheckOut",
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
