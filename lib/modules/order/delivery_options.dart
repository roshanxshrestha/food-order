import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:food_delivery/utils/styles.dart';
import 'package:get/get.dart';

class DeliveryOptions extends StatelessWidget {
  final String value;
  final String title;
  final double amount;
  final bool isFree;

  const DeliveryOptions({
    Key? key,
    required this.value,
    required this.title,
    required this.amount,
    required this.isFree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      return Row(
        children: [
          Radio(
            activeColor: Theme.of(context).primaryColor,
            value: value,
            groupValue: orderController.orderType,
            onChanged: (String? value) =>
                orderController.setDeliveryType(value!),
          ),
          SizedBox(width: Dimension.width10 / 2),
          Text(
            title,
            style: robotoRegular.copyWith(fontSize: Dimension.font16),
          ),
          SizedBox(width: Dimension.width10 / 2),
          Text(
            (value == 'take away' || isFree) ? "(free)" : '(Rs.${amount / 10})',
            style: robotoRegular.copyWith(fontSize: Dimension.font14),
          ),
        ],
      );
    });
  }
}
