import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/recommended_product_controller.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/expandable_text_widget.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:get/get.dart';
import '../backend/app_constants.dart';
import '../backend/controllers/cart_managing_controller.dart';
import '../utilities/route_helper.dart';
import '../utilities/dimensions.dart';

class RecommendedFoodDetailScreen extends StatelessWidget {
  final int listItemIndex;
  final String page;

  const RecommendedFoodDetailScreen(
      {Key? key, required this.listItemIndex, required this.page})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var productModel = Get.find<RecommendedProductController>()
        .recommendedProductListgetter[listItemIndex];
    var controller = Get.find<CartManagingController>();

    controller.checkQuantity(productModel);

    return Scaffold(
        body: CustomScrollView(slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Row(
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
                      width: Dimensions.width30,
                      height: Dimensions.height30,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: const Color(0xFFfcf4e4)),
                      child: Icon(
                        Icons.clear,
                        color: AppColors.mainBlackColor,
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
                              color: AppColors.mainBlackColor,
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
                  })),
                ]),
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(AppConstants.baseUrl +
                    AppConstants.uploadUrl +
                    productModel.img!),
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
                    topRight: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white,
                ),
                child: Center(
                  child: BigText(text: productModel.name!),
                ),
              ),
            ),
            expandedHeight: Dimensions.height300,
            pinned: true,
            backgroundColor: AppColors.yellowColor,
          ),
          SliverToBoxAdapter(
            child: ExpandableTextWidget(
              text: productModel.description!,
            ),
          )
        ]),
        bottomNavigationBar: GetBuilder<CartManagingController>(
          builder: (controller) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
              ),
              height: Dimensions.height120,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                      top: Dimensions.height10,
                      bottom: Dimensions.height10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.setQuantity(false);
                          },
                          child: Container(
                            width: Dimensions.width30,
                            height: Dimensions.height30,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor,
                            ),
                            child: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimensions.width30,
                        ),
                        BigText(
                            text: "₹${productModel.price!.toString()}" " x " +
                                controller.total.toString()),
                        SizedBox(
                          width: Dimensions.width30,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.setQuantity(true);
                          },
                          child: Container(
                            width: Dimensions.width30,
                            height: Dimensions.height30,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor,
                            ),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                    ),
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
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius15),
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.addItem(productModel);
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
                            child: BigText(
                              text: "₹${productModel.price!}|Add to cart",
                              textColor: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
