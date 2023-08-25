import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:food_delivery/common/account_page.dart';
import 'package:food_delivery/common/app_icon.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Profile",
          fontSize: 24,
          color: Colors.white,
        ),
        backgroundColor: AppColors.mainColor,
      ),
      body: Container(
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
                      bigText: const BigText(text: "Roshan"),
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
                      bigText: const BigText(text: "12345667"),
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
                      bigText: const BigText(
                          text: "roshanxshrestha@gmail.commmmmmm"),
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
                      bigText: const BigText(text: "Roshan"),
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
                      bigText: const BigText(text: "Roshan"),
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
                      bigText: const BigText(
                        text: "Roshan",
                      ),
                    ),
                    SizedBox(height: Dimension.height20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
