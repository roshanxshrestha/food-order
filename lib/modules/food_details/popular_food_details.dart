import 'package:flutter/material.dart';
import 'package:food_delivery/common/app_icon.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/common/expandable_text.dart';
import 'package:food_delivery/common/food_info.dart';
import 'package:food_delivery/modules/home_page/food_page_body.dart';
import 'package:food_delivery/modules/home_page/main_page.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class PopularFoodDetails extends StatelessWidget {
  const PopularFoodDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background Image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimension.popFoodImgScreen,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/food0.png"),
                ),
              ),
            ),
          ),
          //icon widget
          Positioned(
            top: Dimension.height45,
            left: Dimension.width20,
            right: Dimension.width20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (() {
                      Get.back();
                    }),
                    child: AppIcon(icon: Icons.close)),
                AppIcon(icon: Icons.shopping_cart_outlined),
              ],
            ),
          ),
          //food details
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimension.popFoodImgScreen - 20,
            child: Container(
              padding: EdgeInsets.all(Dimension.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimension.radius20),
                  topRight: Radius.circular(Dimension.radius20),
                ),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const FoodInfoCol(text: "Food Name"),
                  SizedBox(height: Dimension.height20),
                  const BigText(text: "Details"),
                  SizedBox(height: Dimension.height10),
                  //expandable text widget
                  const Expanded(
                    child: SingleChildScrollView(
                      child: ExpandableText(
                          text:
                              "Food, substance consisting essentially of protein, carbohydrate, fat, and other nutrients used in the body of an organism to sustain growth and vital processes and to furnish energy. The absorption and utilization of food by the body is fundamental to nutrition and is facilitated by digestion.Food, substance consisting essentially of protein, carbohydrate, fat, and other nutrients used in the body of an organism to sustain growth and vital processes and to furnish energy. The absorption and utilization of food by the body is fundamental to nutrition and is facilitated by digestion.Food, substance consisting essentially of protein, carbohydrate, fat, and other nutrients used in the body of an organism to sustain growth and vital processes and to furnish energy. The absorption and utilization of food by the body is fundamental to nutrition and is facilitated by digestion."),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimension.bottomBarHeight,
        padding: EdgeInsets.symmetric(
            vertical: Dimension.height30, horizontal: Dimension.width20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.radius20),
            topRight: Radius.circular(Dimension.radius20),
          ),
          color: AppColors.buttonBackgroundColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(Dimension.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(width: Dimension.width10 / 2),
                  const BigText(text: "0"),
                  SizedBox(width: Dimension.width10 / 2),
                  const Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(Dimension.height20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimension.radius20),
                color: AppColors.mainColor,
              ),
              child: CustomText(
                text: "Rs 10 | Add to Cart",
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
