import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class MainCourseRepo extends GetxService {
  final ApiClient apiClient;
  MainCourseRepo({required this.apiClient});

  Future<Response> getMainCourseList() async {
    return await apiClient.getData(AppConstants.MAIN_COURSE_URI);
  }
}
