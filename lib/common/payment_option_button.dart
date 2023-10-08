import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/styles.dart';
import 'package:get/get.dart';

import '../utils/dimension.dart';

class PaymentOptionButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int index;
  const PaymentOptionButton(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      bool _isSelected = orderController.paymentIndex == index;
      return InkWell(
        onTap: () => orderController.setPaymentIndex(index),
        child: Container(
          margin: EdgeInsets.only(bottom: Dimension.height10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimension.radius15 / 3),
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey[200]!,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: ListTile(
            leading: Icon(
              icon,
              size: 40,
              color: _isSelected
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).disabledColor,
            ),
            title: Text(
              title,
              style: robotoMedium.copyWith(fontSize: Dimension.font20),
            ),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: robotoRegular.copyWith(
                fontSize: Dimension.font16,
                color: Theme.of(context).disabledColor,
              ),
            ),
            trailing: _isSelected
                ? const Icon(
                    Icons.check_circle,
                    color: AppColors.mainColor,
                  )
                : null,
          ),
        ),
      );
    });
  }
}
