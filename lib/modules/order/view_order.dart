import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:get/get.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;

  const ViewOrder({Key? key, required this.isCurrent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<OrderController>(
        builder: (orderController) {
          if (orderController.isLoading == false) {
            late List<OrderModel> orderList;
            if (orderController.currentOrderList.isNotEmpty) {
              orderList = isCurrent
                  ? orderController.currentOrderList.reversed.toList()
                  : orderController.historyOrderList.reversed.toList();
            }
            return Text(orderList.length.toString());
          } else {
            return Text("Loading");
          }
        },
      ),
    );
  }
}
