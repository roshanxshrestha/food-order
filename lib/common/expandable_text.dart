import 'package:flutter/material.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/constants/dimension.dart';
import 'package:food_delivery/utils/colors.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  const ExpandableText({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;
  bool hiddenText = true;
  double textHeight = Dimension.screenHeight / 1.7;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? CustomText(
              text: firstHalf,
              overflow: TextOverflow.visible,
              color: AppColors.paraColor,
            )
          : Column(
              children: [
                CustomText(
                  text: hiddenText
                      ? (firstHalf + "...")
                      : (firstHalf + secondHalf),
                  overflow: TextOverflow.visible,
                  color: AppColors.paraColor,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      hiddenText
                          ? CustomText(
                              text: "Show more",
                              color: AppColors.mainColor,
                            )
                          : CustomText(
                              text: "Show less",
                              color: AppColors.mainColor,
                            ),
                      hiddenText
                          ? const Icon(
                              Icons.keyboard_arrow_down,
                              color: AppColors.mainColor,
                            )
                          : const Icon(
                              Icons.keyboard_arrow_up,
                              color: AppColors.mainColor,
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
