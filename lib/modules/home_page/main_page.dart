import 'package:flutter/material.dart';
import 'package:food_delivery/common/customtext.dart';
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
              margin: const EdgeInsets.only(top: 50, bottom: 15),
              padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            fontSize: 14,
                          ),
                          const Icon(Icons.arrow_drop_down_outlined)
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 45,
                    width: 45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.mainColor,
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            const MainFoodSlider(),
          ],
        ),
      ),
    );
  }
}
