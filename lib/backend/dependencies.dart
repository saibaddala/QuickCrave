import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:foodart/backend/cart_controller.dart';
import 'package:foodart/backend/cart_repo.dart';
import 'package:foodart/backend/popular_product_controller.dart';
import 'package:foodart/backend/popular_product_repo.dart';
import 'package:foodart/backend/recommended_product_controller.dart';
import 'package:foodart/backend/recommended_product_repo.dart';
import 'package:get/get.dart';

Future<void> loadDependencies() async {
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo());

  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
}
