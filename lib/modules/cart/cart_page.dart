import 'package:flutter/material.dart';
import 'package:food_delivery/base/common_text_button.dart';
import 'package:food_delivery/base/no_data_page.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/common/app_icon.dart';
import 'package:food_delivery/common/app_text_field.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/common/payment_option_button.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/location_controller.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/models/place_order_model.dart';
import 'package:food_delivery/modules/order/delivery_options.dart';
import 'package:food_delivery/routes/routes.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/utils/styles.dart';
import 'package:get/get.dart';

import '../../controllers/recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _noteController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: Dimension.height20 * 3,
            left: Dimension.width20,
            right: Dimension.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: AppIcon(
                    icon: Icons.arrow_back_ios_new,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimension.iconSize24,
                  ),
                ),
                // SizedBox(width: Dimension.width20 * 2),
                // GestureDetector(
                //   onTap: () {
                //     Get.toNamed(AppRoutes.getInitial());
                //   },
                //   child: AppIcon(
                //     icon: Icons.home_outlined,
                //     iconColor: Colors.white,
                //     backgroundColor: AppColors.mainColor,
                //     iconSize: Dimension.iconSize24,
                //   ),
                // ),
                Stack(
                  children: [
                    const AppIcon(
                      icon: Icons.shopping_cart_outlined,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                    ),
                    Get.find<PopularProductController>().totalItems >= 1
                        ? const Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              size: 20,
                              iconColor: Colors.white,
                              backgroundColor: Colors.white,
                            ),
                          )
                        : Container(),
                    Get.find<PopularProductController>().totalItems >= 1
                        ? Positioned(
                            right: 3,
                            top: 3,
                            child: CustomText(
                              text: Get.find<PopularProductController>()
                                  .totalItems
                                  .toString(),
                              fontSize: 12,
                              color: AppColors.mainColor,
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (_cartController) {
            return _cartController.getItems.isNotEmpty
                ? Positioned(
                    top: Dimension.height20 * 5,
                    left: Dimension.width20,
                    right: Dimension.width20,
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.only(top: Dimension.height15),
                      child: MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GetBuilder<CartController>(
                          builder: (cartController) {
                            var _cartList = cartController.getItems;
                            return ListView.builder(
                              itemCount: _cartList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      bottom: Dimension.height10),
                                  height: Dimension.height20 * 5,
                                  width: double.maxFinite,
                                  child: GestureDetector(
                                    onTap: () {
                                      var popularIndex =
                                          Get.find<PopularProductController>()
                                              .popularProductList
                                              .indexOf(
                                                  _cartList[index].product!);
                                      if (popularIndex >= 0) {
                                        Get.toNamed(AppRoutes.getPopularFood(
                                            popularIndex, "cartpage"));
                                      } else {
                                        var recommendedIndex = Get.find<
                                                RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(_cartList[index].product!);
                                        if (recommendedIndex < 0) {
                                          Get.snackbar(
                                            "History product",
                                            "Product review is not available for history product!",
                                            backgroundColor:
                                                AppColors.mainColor,
                                            colorText: Colors.white,
                                          );
                                        } else {
                                          Get.toNamed(
                                              AppRoutes.getRecommendedFood(
                                                  recommendedIndex,
                                                  "cartpage"));
                                        }
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: Dimension.height20 * 5,
                                          height: Dimension.height20 * 5,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  AppConstants.BASE_URL +
                                                      AppConstants.UPLOAD_URL +
                                                      cartController
                                                          .getItems[index]
                                                          .img!),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                Dimension.radius20),
                                          ),
                                        ),
                                        SizedBox(width: Dimension.width10),
                                        Expanded(
                                          child: SizedBox(
                                            height: Dimension.height20 * 5,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                CustomText(
                                                  text: cartController
                                                      .getItems[index].name!,
                                                  fontSize: Dimension.font20,
                                                  color: Colors.black,
                                                ),
                                                CustomText(
                                                  text: "Bitter things",
                                                  fontSize: Dimension.font14,
                                                  color: Colors.black,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    CustomText(
                                                      text: "\$ " +
                                                          cartController
                                                              .getItems[index]
                                                              .price
                                                              .toString(),
                                                      fontSize:
                                                          Dimension.font20,
                                                      color: Colors.redAccent,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                          Dimension.height10),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimension
                                                                    .radius20),
                                                        color: Colors.white,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1);
                                                            },
                                                            child: const Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: Dimension
                                                                      .width10 /
                                                                  1),
                                                          Container(
                                                            alignment: Alignment
                                                                .center,
                                                            width: Dimension
                                                                .width30,
                                                            child: BigText(
                                                                text: _cartList[
                                                                        index]
                                                                    .quantity
                                                                    .toString()),
                                                          ),
                                                          SizedBox(
                                                              width: Dimension
                                                                      .width10 /
                                                                  1),
                                                          GestureDetector(
                                                            onTap: () {
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1);
                                                            },
                                                            child: const Icon(
                                                              Icons.add,
                                                              color: AppColors
                                                                  .signColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : const NoDataPage(text: "Your cart is empty!");
          })
        ],
      ),
      bottomNavigationBar:
          GetBuilder<OrderController>(builder: (orderController) {
        _noteController.text = orderController.foodNote;
        return GetBuilder<CartController>(
          builder: (cartController) {
            return Container(
              height: Dimension.bottomBarHeight + 50,
              padding: EdgeInsets.symmetric(
                  vertical: Dimension.height10, horizontal: Dimension.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimension.radius20),
                  topRight: Radius.circular(Dimension.radius20),
                ),
                color: AppColors.buttonBackgroundColor,
              ),
              child: cartController.getItems.isNotEmpty
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () => showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (_) {
                              return Column(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                1,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                Dimension.radius15),
                                            topRight: Radius.circular(
                                                Dimension.radius15),
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              // height: 520,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: Dimension.width20,
                                                vertical: Dimension.height20,
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const PaymentOptionButton(
                                                    icon: Icons.money,
                                                    title: "Cash on Delivery",
                                                    subtitle:
                                                        "pay after delivery",
                                                    index: 0,
                                                  ),
                                                  const PaymentOptionButton(
                                                    icon: Icons.qr_code,
                                                    title: "Online Payment",
                                                    subtitle: "pay safer",
                                                    index: 1,
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Dimension.height20),
                                                  Text(
                                                    "Delivery options",
                                                    style:
                                                        robotoMedium.copyWith(
                                                            fontSize: Dimension
                                                                .font20),
                                                  ),
                                                  const DeliveryOptions(
                                                    isFree: false,
                                                    value: "delivery",
                                                    amount: 1000,
                                                    title: "Home delivery",
                                                  ),
                                                  const DeliveryOptions(
                                                    isFree: false,
                                                    value: "take away",
                                                    amount: 100,
                                                    title: "Take away",
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Dimension.height20),
                                                  Text(
                                                    "Additional notes",
                                                    style:
                                                        robotoMedium.copyWith(
                                                            fontSize: Dimension
                                                                .font20),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Dimension.height10),
                                                  AppTextField(
                                                    textController:
                                                        _noteController,
                                                    hintText:
                                                        "Please enter a message!",
                                                    icon: Icons.note,
                                                    maxLines: true,
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          Dimension.height20),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (Get.find<
                                                              AuthController>()
                                                          .userLoggedIn()) {
                                                        if (Get.find<
                                                                LocationController>()
                                                            .addressList
                                                            .isEmpty) {
                                                          Get.toNamed(AppRoutes
                                                              .getAddressPage());
                                                        } else {
                                                          var location = Get.find<
                                                                  LocationController>()
                                                              .getUserAddress();
                                                          var cart = Get.find<
                                                                  CartController>()
                                                              .getItems;
                                                          var user = Get.find<
                                                                  UserController>()
                                                              .userModel;
                                                          PlaceOrderBody
                                                              placeOrder =
                                                              PlaceOrderBody(
                                                            cart: cart,
                                                            orderAmount: Get.find<
                                                                    CartController>()
                                                                .totalAmount
                                                                .toDouble(),
                                                            orderNote:
                                                                orderController
                                                                    .foodNote,
                                                            orderType:
                                                                orderController
                                                                    .orderType,
                                                            paymentMethod: orderController
                                                                        .paymentIndex ==
                                                                    0
                                                                ? "cash_on_delivery"
                                                                : "digital_payment",
                                                            address: location
                                                                .address,
                                                            latitude: location
                                                                .latitude,
                                                            longitude: location
                                                                .longitude,
                                                            contactPersonName:
                                                                user.name,
                                                            contactPersonNumber:
                                                                user.phone,
                                                            scheduleAt: '',
                                                            distance: 10.0,
                                                          );

                                                          Get.find<
                                                                  OrderController>()
                                                              .placeOrder(
                                                                  placeOrder,
                                                                  _callback);
                                                        }
                                                      } else {
                                                        Get.toNamed(AppRoutes
                                                            .getSignInPage());
                                                      }
                                                    },
                                                    child:
                                                        const CommonTextButton(
                                                      text: "Check Out",
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ).whenComplete(
                            () => orderController.setAdditionalNote(
                              _noteController.text.trim(),
                            ),
                          ),
                          child: const SizedBox(
                            width: double.maxFinite,
                            child: CommonTextButton(text: "Payment options"),
                          ),
                        ),
                        SizedBox(height: Dimension.height10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(Dimension.height20),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Dimension.radius20),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: Dimension.width10 / 1),
                                  Container(
                                    alignment: Alignment.center,
                                    // width: Dimension.width30 * 3,
                                    child: BigText(
                                      text: "Rs. " +
                                          cartController.totalAmount.toString(),
                                    ),
                                  ),
                                  SizedBox(width: Dimension.width10 / 1),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Get.find<AuthController>().userLoggedIn()) {
                                  if (Get.find<LocationController>()
                                      .addressList
                                      .isEmpty) {
                                    Get.toNamed(AppRoutes.getAddressPage());
                                  } else {
                                    var location =
                                        Get.find<LocationController>()
                                            .getUserAddress();
                                    var cart =
                                        Get.find<CartController>().getItems;
                                    var user =
                                        Get.find<UserController>().userModel;
                                    PlaceOrderBody placeOrder = PlaceOrderBody(
                                      cart: cart,
                                      orderAmount: Get.find<CartController>()
                                          .totalAmount
                                          .toDouble(),
                                      orderNote: orderController.foodNote,
                                      orderType: orderController.orderType,
                                      paymentMethod:
                                          orderController.paymentIndex == 0
                                              ? "cash_on_delivery"
                                              : "digital_payment",
                                      address: location.address,
                                      latitude: location.latitude,
                                      longitude: location.longitude,
                                      contactPersonName: user.name,
                                      contactPersonNumber: user.phone,
                                      scheduleAt: '',
                                      distance: 10.0,
                                    );

                                    Get.find<OrderController>()
                                        .placeOrder(placeOrder, _callback);
                                  }
                                } else {
                                  Get.toNamed(AppRoutes.getSignInPage());
                                }
                              },
                              child: const CommonTextButton(text: "Check out"),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Container(),
            );
          },
        );
      }),
    );
  }

  void _callback(bool isSuccess, String message, String orderID) {
    if (isSuccess) {
      Get.find<CartController>().clear();
      Get.find<CartController>().removeCartSharedPreference();
      Get.find<CartController>().addToHistory();
      if (Get.find<OrderController>().paymentIndex == 0) {
        Get.offNamed(AppRoutes.getOrderSuccessPage(orderID, "success"));
      } else {
        Get.toNamed(AppRoutes.getPaymentPage(
            orderID, Get.find<UserController>().userModel.id));
      }
    } else {
      showCustomSnackBar(message);
    }
  }
}
