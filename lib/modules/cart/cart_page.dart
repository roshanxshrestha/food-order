import 'package:flutter/material.dart';
import 'package:food_delivery/common/app_icon.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                SizedBox(width: Dimension.width20 * 2),
                AppIcon(
                  icon: Icons.home,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimension.iconSize24,
                ),
                AppIcon(
                  icon: Icons.shopping_cart,
                  iconColor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimension.iconSize24,
                ),
              ],
            ),
          ),
          Positioned(
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
                      return ListView.builder(
                        itemCount: cartController.getItems.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: Dimension.height10),
                            height: 100,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimension.height20 * 5,
                                  height: Dimension.height20 * 5,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstants
                                              .BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          cartController.getItems[index].img!),
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
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: "\$ " +
                                                  cartController
                                                      .getItems[index].price
                                                      .toString(),
                                              fontSize: Dimension.font20,
                                              color: Colors.redAccent,
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(
                                                  Dimension.height10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimension.radius20),
                                                color: Colors.white,
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      // popularProduct
                                                      // .setQuantity(false);
                                                    },
                                                    child: const Icon(
                                                      Icons.remove,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      width: Dimension.width10 /
                                                          1),
                                                  Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width: Dimension.width30,
                                                      child: const BigText(
                                                          text: "3")),
                                                  SizedBox(
                                                      width: Dimension.width10 /
                                                          1),
                                                  GestureDetector(
                                                    // onTap: () {
                                                    //   popularProduct
                                                    //       .setQuantity(true);
                                                    // },
                                                    child: const Icon(
                                                      Icons.add,
                                                      color:
                                                          AppColors.signColor,
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
                          );
                        },
                      );
                    },
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
