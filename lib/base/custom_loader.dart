import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: Dimension.height20 * 5,
        width: Dimension.height20 * 5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.height45),
            color: Colors.white),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
