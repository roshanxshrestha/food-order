import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'routes/routes.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    Get.find<CartController>().getCartHistoryList();

    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // home: const SplashScreen(),
            // home: const SignInPage(),
            initialRoute: AppRoutes.getSplashPage(),
            getPages: AppRoutes.generateRoute(),
            theme: ThemeData(
              primaryColor: AppColors.mainColor,
              fontFamily: "Lato",
            ),
          );
        });
      },
    );
  }
}
