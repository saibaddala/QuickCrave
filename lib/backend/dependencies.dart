import 'package:foodart/backend/api_client.dart';
import 'package:foodart/backend/app_constants.dart';
import 'package:foodart/backend/controllers/auth_controller.dart';
import 'package:foodart/backend/controllers/cart_controller.dart';
import 'package:foodart/backend/controllers/popular_product_controller.dart';
import 'package:foodart/backend/repos/auth_repo.dart';
import 'package:foodart/backend/repos/cart_repo.dart';
import 'package:foodart/backend/controllers/cart_managing_controller.dart';
import 'package:foodart/backend/repos/location_repo.dart';
import 'package:foodart/backend/repos/popular_product_repo.dart';
import 'package:foodart/backend/controllers/recommended_product_controller.dart';
import 'package:foodart/backend/repos/recommended_product_repo.dart';
import 'package:foodart/backend/repos/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/location_controller.dart';
import 'controllers/user_controller.dart';

Future<void> loadDependencies() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(
      appBaseUrl: AppConstants.baseUrl, sharedPreferences: sharedPreferences));

  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => CartRepo(sharedPreferences: sharedPreferences));
  Get.lazyPut(() =>
      AuthRepo(apiClient: Get.find(), sharedPreferences: sharedPreferences));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(
      apiClient: Get.find(), sharedPreferences: sharedPreferences));


  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(
      () => RecommendedProductController(recommendedProductRepo: Get.find()));
  Get.lazyPut(() => CartController(cartRepo: Get.find()));
  Get.put(CartManagingController());
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => LocationController(locationRepo: Get.find()));
}
