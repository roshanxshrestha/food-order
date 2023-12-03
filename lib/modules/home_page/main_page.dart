import 'package:flutter/material.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/modules/home_page/search_page.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/modules/home_page/food_page_body.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> _loadResources() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: AppColors.mainColor,
        child: SizedBox(
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
                    GestureDetector(
                      onTap: () {
                        Get.to(SearchPage());
                      },
                      child: Container(
                        height: Dimension.height45,
                        width: Dimension.height45,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius15),
                          color: AppColors.mainColor,
                        ),
                        child: Icon(
                          Icons.search,
                          color: Colors.white,
                          size: Dimension.iconSize24,
                        ),
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
        onRefresh: _loadResources);
  }
}
