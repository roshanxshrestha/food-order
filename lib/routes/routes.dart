import 'package:food_delivery/modules/food_details/popular_food_details.dart';
import 'package:food_delivery/modules/food_details/recommended_food_details.dart';
import 'package:food_delivery/modules/home_page/main_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String initial = "/";
  static const String popularFood = "/popularfooddetails";
  static const String recommendedFood = "/recommendedfooddetails";

  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecommendedFood(int pageId) =>
      '$recommendedFood?pageId=$pageId';

  static List<GetPage> generateRoute() {
    List<GetPage> routes = [
      GetPage(name: initial, page: () => const MainPage()),
      GetPage(
          name: popularFood,
          page: () {
            var pageId = Get.parameters['pageId'];
            return PopularFoodDetails(pageId: int.parse(pageId!));
          },
          transition: Transition.rightToLeft),
      GetPage(
          name: recommendedFood,
          page: () {
            var pageId = Get.parameters['pageId'];

            return RecommendedFoodDetails(pageId: int.parse(pageId!));
          },
          transition: Transition.rightToLeft),
    ];
    return routes;
  }
}
