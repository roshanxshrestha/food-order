import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/modules/address/add_address_page.dart';
import 'package:food_delivery/modules/address/pick_address_map.dart';
import 'package:food_delivery/modules/auth/sign_in_page.dart';
import 'package:food_delivery/modules/cart/cart_page.dart';
import 'package:food_delivery/modules/food_details/popular_food_details.dart';
import 'package:food_delivery/modules/food_details/recommended_food_details.dart';
import 'package:food_delivery/modules/payment/payment_page.dart';
import 'package:food_delivery/modules/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../modules/home_page/home_page.dart';
import '../modules/order/order_success_page.dart';

class AppRoutes {
  static const String splashPage = "/splashpage";
  static const String initial = "/";
  static const String popularFood = "/popularfooddetails";
  static const String recommendedFood = "/recommendedfooddetails";
  static const String cartPage = "/cartpage";
  static const String signIn = "/signin";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address-map";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";

  static String getSplashPage() => splashPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => cartPage;
  static String getSignInPage() => signIn;
  static String getAddressPage() => addAddress;
  static String getPickAddressPage() => pickAddressMap;
  static String getPaymentPage(String id, int userID) =>
      '$payment?id=$id&userID=$userID';
  static String getOrderSuccessPage(String orderID, String status) =>
      '$orderSuccess?id=$orderID&status=$status';

  static List<GetPage> generateRoute() {
    List<GetPage> routes = [
      GetPage(
        name: splashPage,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: initial,
        page: () => const HomePage(),
        transition: Transition.fade,
      ),
      GetPage(
          name: popularFood,
          page: () {
            var pageId = Get.parameters['pageId'];
            var page = Get.parameters['page'];
            return PopularFoodDetails(pageId: int.parse(pageId!), page: page!);
          },
          transition: Transition.rightToLeft),
      GetPage(
        name: signIn,
        page: () {
          return const SignInPage();
        },
        transition: Transition.fade,
      ),
      GetPage(
        name: addAddress,
        page: () {
          return const AddAddressPage();
        },
        transition: Transition.fade,
      ),
      GetPage(
        name: pickAddressMap,
        page: () {
          PickAddressMap _pickAddress = Get.arguments;
          return _pickAddress;
        },
        // transition: Transition.fade,
      ),
      GetPage(
        name: recommendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          var page = Get.parameters['page'];
          return RecommendedFoodDetails(
              pageId: int.parse(pageId!), page: page!);
        },
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        transition: Transition.rightToLeft,
      ),
      GetPage(
        name: payment,
        page: () => PaymentPage(
          orderModel: OrderModel(
            id: int.parse(Get.parameters['id']!),
            userId: int.parse(Get.parameters['userID']!),
          ),
        ),
      ),
      GetPage(
          name: orderSuccess,
          page: () => OrderSuccessPage(
                orderID: Get.parameters['id']!,
                status: Get.parameters['status'].toString().contains("success")
                    ? 1
                    : 0,
              ))
    ];
    return routes;
  }
}
