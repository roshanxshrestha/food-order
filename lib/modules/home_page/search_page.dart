import 'package:flutter/material.dart';
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
  final TextEditingController _searchController = TextEditingController();
  final RecommendedProductController _recommendedController = Get.find();
  final PopularProductController _popularController = Get.find();

  late RxList<dynamic> product;
  late RxList<dynamic> displayList;

  @override
  void initState() {
    super.initState();
    product = (_recommendedController.recommendedProductList +
            _popularController.popularProductList)
        .obs;
    displayList = product;
  }

  void updateList(String value) {
    setState(() {
      displayList = (product
              .where((element) =>
                  element.name!.toLowerCase().contains(value.toLowerCase()))
              .toList())
          .obs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search from Menu"),
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
                      controller.totalItems >= 1
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
                      controller.totalItems >= 1
                          ? Positioned(
                              right: 3,
                              top: 3,
                              child: CustomText(
                                text: controller.totalItems.toString(),
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
              controller: _searchController,
              onChanged: updateList,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    Dimension.radius15,
                  ),
                  borderSide: BorderSide.none,
                ),
                hintText: "momos...",
                prefixIcon: const Icon(Icons.search),
                prefixIconColor: AppColors.mainColor,
              ),
            ),
            SizedBox(height: Dimension.height20),
            Expanded(
              child: Obx(() {
                return displayList.isEmpty
                    ? const Center(
                        child: Text("No items found!"),
                      )
                    : ListView.builder(
                        itemCount: displayList.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              int originalIndex =
                                  product.indexOf(displayList[index]);
                              print(
                                  "originalIndex: $originalIndex, index: $index, product.length: ${product.length}");
                              if (originalIndex >= 0 &&
                                  originalIndex < product.length) {
                                Get.toNamed(AppRoutes.getRecommendedFood(
                                    originalIndex, "home"));
                              } else {
                                print("Invalid originalIndex: $originalIndex");
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: Dimension.width20,
                                vertical: Dimension.height10,
                              ),
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
                                              displayList[index].img!,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: Dimension.listViewImg,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(
                                              Dimension.radius20),
                                          bottomRight: Radius.circular(
                                              Dimension.radius20),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: Dimension.width10,
                                          right: Dimension.width10,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BigText(
                                                text: displayList[index].name!),
                                            SizedBox(
                                                height: Dimension.height10),
                                            SmallText(
                                                text: displayList[index]
                                                    .description!),
                                            SizedBox(
                                                height: Dimension.height10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconText(
                                                  icon: Icons.money_sharp,
                                                  text: "Rs. " +
                                                      displayList[index]
                                                          .price!
                                                          .toString(),
                                                  iconColor: Colors.green,
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
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
