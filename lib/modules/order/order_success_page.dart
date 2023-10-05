import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_button.dart';
import 'package:food_delivery/routes/routes.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderID;
  final int status;
  const OrderSuccessPage(
      {Key? key, required this.orderID, required this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(const Duration(seconds: 1), () {
        //
      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimension.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                status == 1
                    ? Icons.check_circle_outline
                    : Icons.check_circle_outline,
                size: 100,
                color: AppColors.mainColor,
              ),
              SizedBox(height: Dimension.height45),
              Text(
                status == 1
                    ? "Your order has been placed successfully!"
                    : "Your order failed!",
                style: TextStyle(fontSize: Dimension.font20),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Dimension.height10),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.height20,
                  vertical: Dimension.height10,
                ),
                child: Text(
                  status == 1 ? "Successful order!" : "Failed order!",
                  style: TextStyle(
                      fontSize: Dimension.font20,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Dimension.height30),
              Padding(
                padding: EdgeInsets.all(Dimension.height20),
                child: CustomButton(
                  buttonText: "Back to Home",
                  onPressed: () => Get.offAllNamed(
                    AppRoutes.getInitial(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
