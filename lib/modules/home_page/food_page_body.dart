import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/common/food_info.dart';
import 'package:food_delivery/common/icon_text.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:food_delivery/routes/routes.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

import '../../utils/dimension.dart';

class MainFoodSlider extends StatefulWidget {
  const MainFoodSlider({Key? key}) : super(key: key);

  @override
  State<MainFoodSlider> createState() => _MainFoodSliderState();
}

class _MainFoodSliderState extends State<MainFoodSlider> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _imgHeight = Dimension.pageViewContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimension.pageView,
                  child: PageView.builder(
                    controller: pageController,
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
              : Padding(
                  padding: EdgeInsets.all(50),
                  child: const CircularProgressIndicator(
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

        //popular text
        SizedBox(height: Dimension.height30),
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
                  text: "Food pairing",
                  fontSize: Dimension.font14,
                  color: AppColors.paraColor,
                ),
              ),
            ],
          ),
        ),
        //recommended
        //list of food items
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? SizedBox(
                  //wrapit with mediaquery.removepadding to remove whitespace covered
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.getRecommendedFood(index));
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
                                    topLeft:
                                        Radius.circular(Dimension.radius20),
                                    bottomLeft:
                                        Radius.circular(Dimension.radius20),
                                  ),
                                  color: Colors.white30,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        AppConstants.UPLOAD_URL +
                                        recommendedProduct
                                            .recommendedProductList[index]
                                            .img!),
                                  ),
                                ),
                              ),
                              //text container
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
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .name!),
                                        SizedBox(height: Dimension.height10),
                                        SmallText(
                                            text: recommendedProduct
                                                .recommendedProductList[index]
                                                .description),
                                        SizedBox(height: Dimension.height10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            IconText(
                                              icon: Icons.circle,
                                              text: "Normal",
                                              iconColor: AppColors.iconColor1,
                                            ),
                                            IconText(
                                              icon: Icons.location_on,
                                              text: "1.7 km",
                                              iconColor: AppColors.mainColor,
                                            ),
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
                )
              : const CircularProgressIndicator(
                  color: AppColors.mainColor,
                );
        })
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
          Get.toNamed(AppRoutes.getPopularFood(index));
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
                child: FoodInfoCol(text: popularProduct.name!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
