import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/modules/auth/signup_page.dart';
import 'package:get/get.dart';
import 'controllers/recommended_product_controller.dart';
import 'modules/auth/sign_in_page.dart';
import 'routes/routes.dart';
import 'helper/dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(
      builder: (_) {
        return GetBuilder<RecommendedProductController>(builder: (_) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // home: const SplashScreen(),
            home: const SignInPage(),
            // initialRoute: AppRoutes.getSplashPage(),

            getPages: AppRoutes.generateRoute(),
          );
        });
      },
    );
  }
}
