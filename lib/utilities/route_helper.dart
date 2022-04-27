import 'package:foodart/screens/cart_page.dart';
import 'package:foodart/screens/home_screen.dart';
import 'package:foodart/screens/main_page_screen.dart';
import 'package:foodart/screens/popular_food_detail_screen.dart';
import 'package:foodart/screens/recommended_food_detail_screen.dart';
import 'package:foodart/screens/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashRoute = "/splashScreen";
  static const String mainPageRoute = "/mainPageScreen";
  static const String homeScreenRoute = "/homeScreen";
  static const String popularFoodRoute = "/popularFoodScreen";
  static const String recommendedFoodRoute = "/recommendedFoodScreen";
  static const String cartPageRoute = "/cartPageScreen";

  static String getSplashScreen() {
    return splashRoute;
  }

  static String getMainPage() {
    return mainPageRoute;
  }

  static String getHomeScreen() {
    return homeScreenRoute;
  }

  static String getCartPage() {
    return cartPageRoute;
  }

  static String getPopularFoodPage(int pageIndex, String page) {
    return "$popularFoodRoute?pageId=$pageIndex&page=$page";
  }

  static String getRecommendedFoodPage(int listItemIndex, String page) {
    return "$recommendedFoodRoute?listItemId=$listItemIndex&page=$page";
  }

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: splashRoute,
        page: () => const SplashScreen(),
      ),
      GetPage(
          name: mainPageRoute,
          page: () => const MainPage(),
          transition: Transition.fadeIn),
      GetPage(
          name: homeScreenRoute,
          page: () => const HomeScreen(),
          transition: Transition.fadeIn),
      GetPage(
          name: popularFoodRoute,
          page: () {
            var pageIndex = Get.parameters["pageId"];
            var page = Get.parameters["page"];
            return PopularFoodDetailScreen(
                pageIndex: int.parse(pageIndex!), page: page!);
          },
          transition: Transition.fadeIn),
      GetPage(
          name: recommendedFoodRoute,
          page: () {
            var listItemId = Get.parameters["listItemId"];
            var page = Get.parameters["page"];
            return RecommendedFoodDetailScreen(
                listItemIndex: int.parse(listItemId!), page: page!);
          },
          transition: Transition.fadeIn),
      GetPage(
          name: cartPageRoute,
          page: () => const CartPage(),
          transition: Transition.fadeIn),
    ];
  }
}
