import 'dart:async';
import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/popular_product_controller.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:get/get.dart';
import '../backend/controllers/recommended_product_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>()
        .fetchRecommendedProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResources();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );

    Timer(
      const Duration(seconds: 3),
      () {
        Get.offNamed(RouteHelper.getMainPage());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        ScaleTransition(
          scale: animation,
          child: Center(
            child: Image.asset(
              "assets/images/logo part 1.png",
              width: Dimensions.width250,
            ),
          ),
        ),
        Center(
          child: Image.asset(
            "assets/images/logo part 2.png",
            width: Dimensions.width250,
          ),
        )
      ]),
    );
  }
}
