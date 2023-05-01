import 'package:flutter/material.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/constants/dimension.dart';
import 'package:food_delivery/modules/home_page/food_slider.dart';
import 'package:food_delivery/utils/colors.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: Dimension.height45, bottom: Dimension.height15),
              padding: EdgeInsets.symmetric(horizontal: Dimension.width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: "Nepal",
                        color: AppColors.mainColor,
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "Kathmandu",
                            color: AppColors.textColor,
                            fontSize: Dimension.font14,
                          ),
                          const Icon(Icons.arrow_drop_down_outlined)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: Dimension.height45,
                    width: Dimension.height45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: Dimension.iconSize24,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: SingleChildScrollView(
                child: MainFoodSlider(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
