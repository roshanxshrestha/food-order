import 'dart:developer';
import 'package:food_delivery/models/popular_products_model.dart';
import 'package:get/get.dart';

import '../data/repository/recomended_product_repo.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({required this.recommendedProductRepo});

  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecommendedProductList() async {
    Response response =
        await recommendedProductRepo.getRecommendedProductList();

    if (response.statusCode == 200) {
      log("got recommended products");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      log(_recommendedProductList.toString());
      _isLoaded = true;
      update();
    } else {
      log(" did not get recommended products");
    }
  }
}
