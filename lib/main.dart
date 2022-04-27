import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/popular_product_controller.dart';
import 'package:foodart/backend/dependencies.dart' as dep;
import 'package:foodart/backend/controllers/recommended_product_controller.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.loadDependencies();
  runApp(
    GetBuilder<PopularProductController>(
      builder: (controller) {
        return GetBuilder<RecommendedProductController>(
          builder: (controller) {
            return GetMaterialApp(
              initialRoute: RouteHelper.getSplashScreen(),
              debugShowCheckedModeBanner: false,
              getPages: RouteHelper.getPages(),
            );
          },
        );
      },
    ),
  );
}
