import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/name_review_geographics_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/dimensions.dart';
import '../reusable_widgets/icon_and_text_widget.dart';
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
        Container(
          margin: EdgeInsets.only(top: Dimensions.height20),
          height: Dimensions.height320,
          child: PageView.builder(
            controller: pageController,
            itemCount: 5,
            itemBuilder: (context, index) => _buildPageViewItem(index),
          ),
        ),
        DotsIndicator(
          dotsCount: 5,
          position: currentPageValue,
          decorator: DotsDecorator(
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            activeColor: AppColors.mainColor,
          ),
        ),
        SizedBox(
          height: Dimensions.height10,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width10),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                BigText(
                  text: "Popular",
                  textColor: AppColors.mainBlackColor,
                ),
              ]),
        ),
        SizedBox(
          height: Dimensions.height5,
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: ((context, index) => buildListViewItem(index))),
      ],
    );
  }

  Widget _buildPageViewItem(int index) {
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
      child: Stack(
        children: [
          Container(
            height: Dimensions.height220,
            margin: EdgeInsets.only(
                left: Dimensions.width5, right: Dimensions.width5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius35),
              image: const DecorationImage(
                image: AssetImage("assets/images/food0.png"),
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
              child: const NameAndReviewAndGeographicsWidget(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildListViewItem(int index) {
    return Container(
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
              image: const DecorationImage(
                image: AssetImage(
                  "assets/images/food0.png",
                ),
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
                        text: "Nutritious Meal By Foodart on Bakers adda",
                        wantOverflow: true,
                        textSize: Dimensions.fontSize17,
                      ),
                      const SmallText(text: "With Chinese Flavour"),
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
                          SizedBox(
                            width: Dimensions.width5,
                          ),
                          IconAndText(
                            iconData: Icons.location_on,
                            text: "4.5km",
                            iconColor: AppColors.mainColor,
                            textColor: AppColors.textColor,
                            iconSize: Dimensions.iconSize15,
                            textSize: Dimensions.fontSize15,
                          ),
                          SizedBox(
                            width: Dimensions.width5,
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
                  )),
            ),
          )
        ],
      ),
    );
  }
}
