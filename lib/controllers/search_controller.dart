import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/recommended_product_controller.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  RxList<dynamic> product = [].obs;
  RxList<dynamic> displayList = [].obs;

  void initializeData() {
    product.assignAll(
      Get.find<RecommendedProductController>().recommendedProductList +
          Get.find<PopularProductController>().popularProductList,
    );
    displayList.assignAll(product);
  }

  void updateList(String value) {
    displayList.assignAll(
      product
          .where((element) =>
              element['name'].toLowerCase().contains(value.toLowerCase()))
          .toList(),
    );
    update();
  }
}
