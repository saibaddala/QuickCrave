import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:foodart/backend/controllers/cart_controller.dart';
import 'package:foodart/backend/controllers/popular_product_controller.dart';
import 'package:foodart/backend/repos/cart_repo.dart';
import 'package:foodart/backend/controllers/cart_managing_controller.dart';
import 'package:foodart/backend/repos/popular_product_repo.dart';
import 'package:foodart/backend/controllers/recommended_product_controller.dart';
import 'package:foodart/backend/repos/recommended_product_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadDependencies() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences:Get.find()));

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartManagingController());
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
