import 'dart:developer';
import 'package:food_delivery/data/repository/a_main_course_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class MainCourseController extends GetxController {
  final MainCourseRepo mainCourseRepo;
  MainCourseController({required this.mainCourseRepo});

  List<dynamic> _mainCourseList = [];
  List<dynamic> get mainCourseList => _mainCourseList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getMainCourseList() async {
    Response response = await mainCourseRepo.getMainCourseList();

    if (response.statusCode == 200) {
      _mainCourseList = [];
      _mainCourseList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      log(" did not get main course products");
    }
  }
}
