import 'package:food_delivery/modules/cart/cart_page.dart';
import 'package:food_delivery/modules/food_details/popular_food_details.dart';
import 'package:food_delivery/modules/food_details/recommended_food_details.dart';
import 'package:food_delivery/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../modules/home_page/home_page.dart';

class AppRoutes {
  static const String splashPage = "/splashpage";
  static const String initial = "/";
  static const String popularFood = "/popularfooddetails";
  static const String recommendedFood = "/recommendedfooddetails";
  static const String cartPage = "/cartpage";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;

  static List<GetPage> generateRoute() {
    List<GetPage> routes = [
      GetPage(name: splashPage, page: () => const SplashScreen()),
      GetPage(name: initial, page: () => const HomePage()),
      GetPage(
          name: popularFood,
          page: () {
            var pageId = Get.parameters['pageId'];
            var page = Get.parameters['page'];
            return PopularFoodDetails(pageId: int.parse(pageId!), page: page!);
          },
          transition: Transition.rightToLeft),
      GetPage(
          name: recommendedFood,
          page: () {
            var pageId = Get.parameters['pageId'];
            var page = Get.parameters['page'];
            return RecommendedFoodDetails(
                pageId: int.parse(pageId!), page: page!);
          },
          transition: Transition.rightToLeft),
      GetPage(
          name: cartPage,
          page: () {
            return const CartPage();
          },
          transition: Transition.rightToLeft)
    ];
    return routes;
  }
}
