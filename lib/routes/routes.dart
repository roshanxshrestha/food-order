import 'package:food_delivery/modules/food_details/popular_food_details.dart';
import 'package:food_delivery/modules/food_details/recommended_food_details.dart';
import 'package:food_delivery/modules/home_page/main_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initial = "/";

  // static String getPopularFood() => '$popularfooddetails';

  static List<GetPage> generateRoute() {
    List<GetPage> routes = [
      GetPage(name: "/mainpage", page: () => const MainPage()),
      GetPage(
          name: "/recommendedfooddetails",
          page: () => const RecommendedFoodDetails()),
      GetPage(
          name: "/popularfooddetails",
          page: () {
            return const PopularFoodDetails();
          },
          transition: Transition.topLevel),
      GetPage(
          name: "/recommendedfooddetails",
          page: () {
            return const RecommendedFoodDetails();
          },
          transition: Transition.rightToLeft),
    ];
    return routes;
  }
}
