import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:foodart/backend/controllers/cart_managing_controller.dart';
import 'package:foodart/backend/controllers/popular_product_controller.dart';
import 'package:foodart/backend/models/product_model.dart';
import 'package:foodart/backend/controllers/recommended_product_controller.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/name_review_geographics_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:get/get.dart';
import '../reusable_widgets/icon_and_text_widget.dart';
import '../utilities/route_helper.dart';
import '../utilities/colors.dart';

class HomeScreenItemsBuilder extends StatefulWidget {
  const HomeScreenItemsBuilder({Key? key}) : super(key: key);

  @override
  State<HomeScreenItemsBuilder> createState() => _HomeScreenItemsBuilderState();
}

class _HomeScreenItemsBuilderState extends State<HomeScreenItemsBuilder> {
  final PageController pageController = PageController(viewportFraction: 0.9);
  var currentPageValue = 0.0;
  var scalingFactor = 0.8;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetBuilder<PopularProductController>(
            builder: (popularproductcontroller) {
          return popularproductcontroller.isLoaded
              ? Container(
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  height: Dimensions.height320,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularproductcontroller
                        .popularProductListgetter.length,
                    itemBuilder: (context, index) => _buildPageViewItem(
                        index,
                        popularproductcontroller
                            .popularProductListgetter[index]),
                  ),
                )
              : Container(
                  margin: EdgeInsets.only(top: Dimensions.height20),
                  height: Dimensions.height320,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ),
                );
        }),
        GetBuilder<PopularProductController>(
            builder: (popularproductcontroller) {
          return DotsIndicator(
              dotsCount: popularproductcontroller
                      .popularProductListgetter.isEmpty
                  ? 1
                  : popularproductcontroller.popularProductListgetter.length,
              position: currentPageValue,
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                activeColor: AppColors.mainColor,
              ));
        }),
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                BigText(
                  text: "Recommended",
                  textColor: AppColors.mainBlackColor,
                ),
              ]),
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProductController) {
          return recommendedProductController.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProductController
                      .recommendedProductListgetter.length,
                  itemBuilder: ((context, index) => buildListViewItem(
                        index,
                        recommendedProductController
                            .recommendedProductListgetter[index],
                      )),
                )
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
      ],
    );
  }

  Widget _buildPageViewItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == currentPageValue.floor()) {
      var currentScaling = 1 - (currentPageValue - index) * (1 - scalingFactor);
      var currentTranslation = Dimensions.height220 * (1 - currentScaling) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScaling, 1)
        ..setTranslationRaw(0, currentTranslation, 0);
    } else if (index == currentPageValue.floor() + 1) {
      var currentScaling =
          scalingFactor + (currentPageValue - index + 1) * (1 - scalingFactor);
      var currentTranslation = Dimensions.height220 * (1 - currentScaling) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScaling, 1)
        ..setTranslationRaw(0, currentTranslation, 0);
    } else if (index == currentPageValue.floor() - 1) {
      var currentScaling = 1 - (currentPageValue - index) * (1 - scalingFactor);
      var currentTranslation = Dimensions.height220 * (1 - currentScaling) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScaling, 1)
        ..setTranslationRaw(0, currentTranslation, 0);
    } else {
      var currentScaling = 0.8;
      var currentTranslation = Dimensions.height220 * (1 - scalingFactor) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScaling, 1)
        ..setTranslationRaw(0, currentTranslation, 0);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RouteHelper.getPopularFoodPage(index, "home"));
        },
        child: Stack(
          children: [
            Container(
              height: Dimensions.height220,
              margin: EdgeInsets.only(
                  left: Dimensions.width5, right: Dimensions.width5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius35),
                color: AppColors.mainColor,
                image: DecorationImage(
                  image: NetworkImage(
                      AppConstants.baseUrl + AppConstants.uploadUrl + popularProduct.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height15,
                ),
                height: Dimensions.height130,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      Dimensions.radius40,
                    ),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0,
                          offset: Offset(0, 5)),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5, 0),
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0),
                      ),
                    ]),
                child: NameAndReviewAndGeographicsWidget(
                  popularProduct: popularProduct,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildListViewItem(int index, ProductModel recommendedProduct) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteHelper.getRecommendedFoodPage(index, "homepage"));
      },
      child: Container(
        margin: EdgeInsets.only(
          bottom: Dimensions.height10,
          left: Dimensions.width15,
          right: Dimensions.width15,
        ),
        child: Row(
          children: [
            Container(
              height: Dimensions.height130,
              width: Dimensions.width130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius20),
                color: AppColors.mainColor,
                image: DecorationImage(
                  image: NetworkImage(AppConstants.baseUrl +
                      AppConstants.uploadUrl +
                      recommendedProduct.img!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: Dimensions.height120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Dimensions.radius20),
                      bottomRight: Radius.circular(Dimensions.radius20)),
                ),
                child: Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.width10,
                      right: Dimensions.width5,
                      top: Dimensions.height20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: recommendedProduct.name!,
                        wantOverflow: true,
                        textSize: Dimensions.fontSize17,
                      ),
                      SmallText(
                        text: recommendedProduct.description!.toString(),
                        wantOverflow: true,
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconAndText(
                            iconData: Icons.circle_sharp,
                            text: "Normal",
                            iconColor: AppColors.iconColor1,
                            textColor: AppColors.textColor,
                            iconSize: Dimensions.iconSize15,
                            textSize: Dimensions.fontSize15,
                          ),
                          IconAndText(
                            iconData: Icons.location_on,
                            text: "4.5km",
                            iconColor: AppColors.mainColor,
                            textColor: AppColors.textColor,
                            iconSize: Dimensions.iconSize15,
                            textSize: Dimensions.fontSize15,
                          ),
                          IconAndText(
                            iconData: Icons.timer,
                            text: "37min",
                            iconColor: AppColors.iconColor2,
                            textColor: AppColors.textColor,
                            iconSize: Dimensions.iconSize15,
                            textSize: Dimensions.fontSize15,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
