import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/common/account_page.dart';
import 'package:food_delivery/common/app_icon.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/common/icon_text.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/controllers/user_controller.dart';
import 'package:food_delivery/modules/auth/sign_in_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
      print("useer had logged in");
    }
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Profile",
          fontSize: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<UserController>(
        builder: (userController) {
          return _userLoggedIn
              ? (userController.isLoading
                  ? Container(
                      width: double.maxFinite,
                      margin: EdgeInsets.only(top: Dimension.height20),
                      child: Column(
                        children: [
                          //image
                          AppIcon(
                            icon: Icons.person,
                            backgroundColor: AppColors.mainColor,
                            iconColor: Colors.white,
                            iconSize: Dimension.height15 * 5,
                            size: Dimension.height15 * 10,
                          ),
                          SizedBox(height: Dimension.height30),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // name
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.person,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimension.height10 * 2.5,
                                      size: Dimension.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.name),
                                  ),
                                  SizedBox(height: Dimension.height20),
                                  //phone
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.phone,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimension.height10 * 2.5,
                                      size: Dimension.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.phone),
                                  ),
                                  SizedBox(height: Dimension.height20),
                                  //email
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.email,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimension.height10 * 2.5,
                                      size: Dimension.height10 * 5,
                                    ),
                                    bigText: BigText(
                                        text: userController.userModel.email),
                                  ),
                                  SizedBox(height: Dimension.height20),
                                  //address
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.location_on,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimension.height10 * 2.5,
                                      size: Dimension.height10 * 5,
                                    ),
                                    bigText: const BigText(text: "location"),
                                  ),
                                  SizedBox(height: Dimension.height20),
                                  //message
                                  AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.message,
                                      backgroundColor: AppColors.yellowColor,
                                      iconColor: Colors.white,
                                      iconSize: Dimension.height10 * 2.5,
                                      size: Dimension.height10 * 5,
                                    ),
                                    bigText: const BigText(text: "messages"),
                                  ),
                                  SizedBox(height: Dimension.height20),
                                  //message
                                  GestureDetector(
                                    onTap: () {
                                      if (Get.find<AuthController>()
                                          .userLoggedIn()) {
                                        Get.find<AuthController>()
                                            .clearSharedData();
                                        Get.find<CartController>().clear();
                                        Get.find<CartController>()
                                            .clearCartHistory();
                                        Get.offNamed(AppRoutes.getSignInPage());
                                      } else {
                                        print('you arent logged in');
                                      }
                                    },
                                    child: AccountWidget(
                                      appIcon: AppIcon(
                                        icon: Icons.logout,
                                        backgroundColor: Colors.red,
                                        iconColor: Colors.white,
                                        iconSize: Dimension.height10 * 2.5,
                                        size: Dimension.height10 * 5,
                                      ),
                                      bigText: const BigText(
                                        text: "Logout",
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Dimension.height20),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const CustomLoader())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.maxFinite,
                        height: Dimension.height30 * 5,
                        margin:
                            EdgeInsets.symmetric(horizontal: Dimension.width20),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius20),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage("assets/image/signintocontinue.png"),
                          ),
                        ),
                      ),
                      SizedBox(height: Dimension.screenHeight * 0.02),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.signIn);
                        },
                        child: Container(
                          width: double.maxFinite,
                          height: Dimension.height45,
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimension.width20),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius:
                                BorderRadius.circular(Dimension.radius15),
                          ),
                          child: Center(
                            child: CustomText(
                              text: "Sign in",
                              color: Colors.white,
                              fontSize: Dimension.font20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
