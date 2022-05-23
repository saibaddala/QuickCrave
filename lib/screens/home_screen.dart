import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodart/backend/controllers/cart_controller.dart';
import 'package:foodart/builders/home_screen_items_builder.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:get/get.dart';
import '../backend/controllers/popular_product_controller.dart';
import '../backend/controllers/recommended_product_controller.dart';
import '../utilities/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().fetchPopularProductList();
    await Get.find<RecommendedProductController>()
        .fetchRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getStoredCartListFromRepo();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
        ),
      ),
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        color: AppColors.mainColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: Dimensions.width20,
                right: Dimensions.width20,
                top: Dimensions.height40,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BigText(
                        text: "India",
                        textColor: AppColors.mainColor,
                      ),
                      Row(
                        children: const [
                          SmallText(text: "Tirupati"),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: Dimensions.height40,
                    width: Dimensions.width40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        Dimensions.radius10,
                      ),
                      color: AppColors.mainColor,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: HomeScreenItemsBuilder(),
              ),
            )
          ],
        ),
        onRefresh: _loadResources,
      ),
    );
  }
}
