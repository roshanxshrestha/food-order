// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';

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
    this.fontSize = 18,
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
        fontSize: fontSize,
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
