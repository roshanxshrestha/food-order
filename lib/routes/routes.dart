import 'package:food_delivery/modules/home_page/main_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static List<GetPage> generateRoute() {
    List<GetPage> routes = [
      GetPage(name: "/mainpage", page: () => const MainPage()),
    ];
    return routes;
  }
}
