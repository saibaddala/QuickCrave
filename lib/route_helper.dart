import 'package:foodart/screens/cart_page.dart';
import 'package:foodart/screens/home_screen.dart';
import 'package:foodart/screens/main_page.dart';
import 'package:foodart/screens/popular_food_detail_screen.dart';
import 'package:foodart/screens/recommended_food_detail_screen.dart';
import 'package:foodart/screens/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {

  static const String initialRoute = "/";
  static const String mainPageRoute = "/mainPage";
  static const String splashRoute = "/splash";
  static const String popularFoodRoute = "/popularFood";
  static const String recommendedFoodRoute = "/recommendedFood";
  static const String cartPageRoute = "/cartPage";

  static String getMainPage() {
    return "$mainPageRoute";
  }
  static String getHomeScreen() {
    return "$initialRoute";
  }
  static String getSplashScreen() {
    return "$splashRoute";
  }

  static String getPopularFoodPage(int PageIndex, String page) {
    return "$popularFoodRoute?pageId=$PageIndex&page=$page";
  }

  static String getRecommendedFoodPage(int listItemIndex, String page) {
    return "$recommendedFoodRoute?listItemId=$listItemIndex&page=$page";
  }

  static String getCartPage() {
    return "$cartPageRoute";
  }

  static List<GetPage> getPages() {
    return [
      GetPage(
          name: mainPageRoute,
          page: () => const MainPage(),
          transition: Transition.fadeIn),
      GetPage(
          name: splashRoute,
          page: () => const SplashScreen(),
         ),
      GetPage(
          name: initialRoute,
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
                listItemIndex: int.parse(listItemId!),page:page!);
          },
          transition: Transition.fadeIn),
      GetPage(
          name: cartPageRoute,
          page: () => const CartPage(),
          transition: Transition.fadeIn),
    ];
  }
}
