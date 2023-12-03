import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_appbar.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

import '../../common/app_icon.dart';
import '../../common/customtext.dart';
import '../../common/icon_text.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/routes.dart';
import '../../utils/app_constants.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<dynamic> product;
  late List<dynamic> displayList;

  @override
  void initState() {
    super.initState();
    product = Get.find<RecommendedProductController>().recommendedProductList +
        Get.find<PopularProductController>().popularProductList;
    displayList = List.from(product);
  }

  void updateList(String value) {
    setState(() {
      displayList = product
          .where((element) =>
              element.name!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Foods"),
        backgroundColor: AppColors.mainColor,
        actions: [
          GetBuilder<PopularProductController>(
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  if (controller.totalItems >= 1) {
                    Get.toNamed(AppRoutes.getCartPage());
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimension.width20),
                  child: Stack(
                    children: [
                      const AppIcon(
                        icon: Icons.shopping_cart_outlined,
                      ),
                      Get.find<PopularProductController>().totalItems >= 1
                          ? const Positioned(
                              right: 0,
                              top: 0,
                              child: AppIcon(
                                icon: Icons.circle,
                                size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor,
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
                                color: Colors.white,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: updateList,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimension.radius15,
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: "momos",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: AppColors.mainColor,
              ),
            ),
            SizedBox(height: Dimension.height20),
            Expanded(
              child: displayList.length == 0
                  ? Center(
                      child: Text("No items found!"),
                    )
                  : ListView.builder(
                      itemCount: displayList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                                AppRoutes.getRecommendedFood(index, "home"));
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: Dimension.width20,
                                vertical: Dimension.height10),
                            child: Row(
                              children: [
                                Container(
                                  width: Dimension.listViewImg,
                                  height: Dimension.listViewImg,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(Dimension.radius20),
                                      bottomLeft:
                                          Radius.circular(Dimension.radius20),
                                    ),
                                    color: Colors.white30,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          AppConstants.BASE_URL +
                                              AppConstants.UPLOAD_URL +
                                              displayList[index].img!),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: Dimension.listViewImg,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight:
                                            Radius.circular(Dimension.radius20),
                                        bottomRight:
                                            Radius.circular(Dimension.radius20),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimension.width10,
                                          right: Dimension.width10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                              text: displayList[index].name!),
                                          SizedBox(height: Dimension.height10),
                                          SmallText(
                                              text: displayList[index]
                                                  .description!),
                                          SizedBox(height: Dimension.height10),
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconText(
                                                icon: Icons.access_time_rounded,
                                                text: "10 min",
                                                iconColor: AppColors.iconColor2,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
