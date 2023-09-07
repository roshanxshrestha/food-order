import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if (response.statusCode == 401) {
      Get.offNamed(AppRoutes.getSignInPage());
    } else {
      showCustomSnackBar(response.statusText!);
    }
  }
}
