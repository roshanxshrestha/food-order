import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/common/food_info.dart';
import 'package:food_delivery/common/icon_text.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/routes.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../utils/dimension.dart';

class MainFoodSlider extends StatefulWidget {
  const MainFoodSlider({Key? key}) : super(key: key);

  @override
  State<MainFoodSlider> createState() => _MainFoodSliderState();
}

class _MainFoodSliderState extends State<MainFoodSlider>
    with TickerProviderStateMixin {
  final RecommendedProductController _recommendedController = Get.find();

  late List<dynamic> displayList;
  late List<dynamic> product;
  PageController popularProductsPageController =
      PageController(viewportFraction: 0.85);
  PageController recommendedProductsPageController =
      PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _imgHeight = Dimension.pageViewContainer;

  @override
  void initState() {
    super.initState();
    product = (_recommendedController.recommendedProductList);
    displayList = product;

    popularProductsPageController.addListener(() {
      setState(() {
        _currPageValue = popularProductsPageController.page!;
      });
    });

    recommendedProductsPageController.addListener(() {
      setState(() {
        _currPageValue = recommendedProductsPageController.page!;
      });
    });
  }

  @override
  void dispose() {
    popularProductsPageController.dispose();
    recommendedProductsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: "Our Special",
                fontSize: Dimension.font20,
              ),
              SizedBox(width: Dimension.width10),
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: const Icon(
                  Icons.circle,
                  size: 7,
                  color: AppColors.paraColor,
                ),
              ),
              SizedBox(width: Dimension.width10),
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: CustomText(
                  text: "Most Loved",
                  fontSize: Dimension.font14,
                  color: AppColors.paraColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimension.height20),
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimension.pageView,
                  child: PageView.builder(
                    controller: popularProductsPageController,
                    itemCount: popularProducts.popularProductList.isEmpty
                        ? 1
                        : popularProducts.popularProductList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return _buildSliderItem(position,
                          popularProducts.popularProductList[position]);
                    },
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.all(50),
                  child: CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ),
                );
        }),

        //dots
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 1
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        SizedBox(height: Dimension.height20),

        Container(
          margin: EdgeInsets.only(left: Dimension.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: "Recommended",
                fontSize: Dimension.font20,
              ),
              SizedBox(width: Dimension.width10),
              Container(
                margin: const EdgeInsets.only(top: 3),
                child: const Icon(
                  Icons.circle,
                  size: 7,
                  color: AppColors.paraColor,
                ),
              ),
              SizedBox(width: Dimension.width10),
              Container(
                margin: const EdgeInsets.only(top: 2),
                child: CustomText(
                  text: "You may like",
                  fontSize: Dimension.font14,
                  color: AppColors.paraColor,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: Dimension.height20),
        //recommended
        GetBuilder<CartController>(
          builder: (_cartController) {
            var cartList = _cartController.getCartHistoryList();
            displayList = (product
                    .where((element) => cartList.any((cartItem) => element.name!
                        .toLowerCase()
                        .split(' ')
                        .any((word) => cartItem.name!
                            .toLowerCase()
                            .contains(word.toLowerCase()))))
                    .take(100)
                    .toList())
                .obs;

            return cartList.isNotEmpty
                ? GetBuilder<RecommendedProductController>(
                    builder: (recommendedProducts) {
                    return recommendedProducts.isLoaded
                        ? SizedBox(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: displayList.length,
                                itemBuilder: (context, index) {
                                  final originalIndex =
                                      product.indexOf(displayList[index]);
                                  return GestureDetector(
                                    onTap: () {
                                      // Pass the original index of the item
                                      Get.toNamed(AppRoutes.getRecommendedFood(
                                          originalIndex, "home"));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              Dimension.radius20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.2),
                                              offset: Offset(0, 3),
                                              blurRadius: 6,
                                              spreadRadius: 0,
                                            ),
                                          ]),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: Dimension.width20,
                                          vertical: Dimension.height10),
                                      child: Row(
                                        children: [
                                          //image section
                                          Container(
                                            width: Dimension.listViewImg,
                                            height: Dimension.listViewImg,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimension.radius20),
                                                bottomLeft: Radius.circular(
                                                    Dimension.radius20),
                                              ),
                                              color: Colors.white30,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants
                                                        .BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    displayList[index].img!),
                                              ),
                                            ),
                                          ),
                                          //text container
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
                                                    right: Dimension.width10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    BigText(
                                                        text: displayList[index]
                                                            .name!),
                                                    SizedBox(
                                                        height:
                                                            Dimension.height10),
                                                    SmallText(
                                                        text: displayList[index]
                                                            .description),
                                                    SizedBox(
                                                        height:
                                                            Dimension.height10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconText(
                                                          icon: Icons.money,
                                                          text: "Rs. " +
                                                              displayList[index]
                                                                  .price
                                                                  .toString(),
                                                          iconColor:
                                                              Colors.green,
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
                          )
                        : const Padding(
                            padding: EdgeInsets.all(50),
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                          );
                  })
                : GetBuilder<RecommendedProductController>(
                    builder: (recommendedProducts) {
                    displayList = product
                        .where((element) =>
                            element.name!
                                .toLowerCase()
                                .contains("Chicken".toLowerCase()) ||
                            element.name!
                                .toLowerCase()
                                .contains("momo".toLowerCase()))
                        .toList();
                    return recommendedProducts.isLoaded
                        ? SizedBox(
                            child: MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: displayList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed(AppRoutes.getRecommendedFood(
                                          index, "home"));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: Dimension.width20,
                                          vertical: Dimension.height10),
                                      child: Row(
                                        children: [
                                          //image section
                                          Container(
                                            width: Dimension.listViewImg,
                                            height: Dimension.listViewImg,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    Dimension.radius20),
                                                bottomLeft: Radius.circular(
                                                    Dimension.radius20),
                                              ),
                                              color: Colors.white30,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(AppConstants
                                                        .BASE_URL +
                                                    AppConstants.UPLOAD_URL +
                                                    displayList[index].img!),
                                              ),
                                            ),
                                          ),
                                          //text container
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
                                                    right: Dimension.width10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    BigText(
                                                        text: displayList[index]
                                                            .name!),
                                                    SizedBox(
                                                        height:
                                                            Dimension.height10),
                                                    SmallText(
                                                        text: displayList[index]
                                                            .description),
                                                    SizedBox(
                                                        height:
                                                            Dimension.height10),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        IconText(
                                                          icon: Icons.money,
                                                          text: "Rs. " +
                                                              displayList[index]
                                                                  .price
                                                                  .toString(),
                                                          iconColor:
                                                              Colors.green,
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
                          )
                        : const Padding(
                            padding: EdgeInsets.all(50),
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                          );
                  });
          },
        ),
        //all foods
      ],
    );
  }

  //food slider animation

  Widget _buildSliderItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _imgHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _imgHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _imgHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _imgHeight * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoutes.getPopularFood(index, "home"));
        },
        child: Stack(
          children: [
            Container(
              height: _imgHeight,
              margin: EdgeInsets.symmetric(horizontal: Dimension.width10),
              decoration: BoxDecoration(
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF69c5bf),
                borderRadius: BorderRadius.circular(Dimension.radius30),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(AppConstants.BASE_URL +
                      AppConstants.UPLOAD_URL +
                      popularProduct.img!),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimension.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimension.width30,
                    right: Dimension.width30,
                    bottom: Dimension.height10),
                padding: EdgeInsets.all(Dimension.height15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Dimension.radius20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: FoodInfoCol(
                  text: popularProduct.name!,
                  price: popularProduct.price!,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
