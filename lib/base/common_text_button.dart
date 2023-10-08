import 'package:flutter/material.dart';
import '../common/customtext.dart';
import '../utils/colors.dart';
import '../utils/dimension.dart';

class CommonTextButton extends StatelessWidget {
  final String text;
  const CommonTextButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Dimension.height20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            blurRadius: Dimension.radius20 / 2,
            color: AppColors.mainColor.withOpacity(0.3),
          )
        ],
        borderRadius: BorderRadius.circular(Dimension.radius20),
        color: AppColors.mainColor,
      ),
      child: Center(
        child: CustomText(
          text: text,
          color: Colors.white,
        ),
      ),
    );
  }
}
