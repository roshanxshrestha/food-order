// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';

import '../utils/dimension.dart';

class CustomText extends StatelessWidget {
  final String text;
  Color? color;
  double fontSize;
  double textHeight;
  String? fontFamily;
  FontWeight? fontWeight;
  TextOverflow overflow;
  TextAlign align;

  CustomText({
    Key? key,
    required this.text,
    this.color = AppColors.mainBlackColor,
    this.fontWeight = FontWeight.w400,
    this.fontSize = 16,
    this.textHeight = 1.2,
    this.overflow = TextOverflow.ellipsis,
    this.align = TextAlign.justify,
    this.fontFamily = "Roboto",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize == 0 ? Dimension.font20 : fontSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: color,
        height: textHeight,
      ),
      overflow: overflow,
      textAlign: align,
    );
  }
}

class SmallText extends StatelessWidget {
  final String text;
  const SmallText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      fontSize: Dimension.font14,
      color: AppColors.paraColor,
    );
  }
}

class BigText extends StatelessWidget {
  final String text;
  const BigText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomText(
      text: text,
      fontSize: Dimension.font20,
      color: AppColors.mainBlackColor,
    );
  }
}
