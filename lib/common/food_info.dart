import 'package:flutter/material.dart';

import '../utils/dimension.dart';
import '../utils/colors.dart';
import 'customtext.dart';
import 'icon_text.dart';

class FoodInfoCol extends StatelessWidget {
  final String text;
  const FoodInfoCol({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          fontSize: Dimension.font20,
        ),
        SizedBox(height: Dimension.height10),
        Row(
          children: [
            Row(
              children: [
                Wrap(
                  children: List.generate(
                    5,
                    (index) {
                      return const Icon(
                        Icons.star,
                        size: 14,
                        color: AppColors.mainColor,
                      );
                    },
                  ),
                ),
                SizedBox(width: Dimension.height10),
                CustomText(
                  text: "5",
                  color: AppColors.paraColor,
                ),
              ],
            ),
            SizedBox(width: Dimension.width10),
            Row(
              children: [
                CustomText(
                  text: "1234",
                  color: AppColors.paraColor,
                ),
                const SizedBox(width: 10),
                CustomText(
                  text: "comments",
                  color: AppColors.paraColor,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: Dimension.height10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    );
  }
}
