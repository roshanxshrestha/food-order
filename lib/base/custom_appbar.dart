import 'package:flutter/material.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/utils/dimension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool backButtonExists;
  final Function? onBackPressed;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.backButtonExists = true,
    this.onBackPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomText(
        text: title,
        color: Colors.white,
        fontSize: Dimension.font16,
      ),
      centerTitle: true,
      backgroundColor: Theme.of(context).primaryColor,
      elevation: 0,
      leading: backButtonExists
          ? IconButton(
              onPressed: () => onBackPressed != null
                  ? onBackPressed!()
                  : Navigator.pushReplacementNamed(context, "/initial"),
              icon: const Icon(Icons.arrow_back_ios),
            )
          : const SizedBox(),
    );
  }

  @override
  Size get preferredSize => Size(500, 50);
}
