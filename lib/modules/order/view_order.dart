import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
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
            return SizedBox(
              width: Dimension.screenWidth,
              child: Padding(
                padding: EdgeInsets.all(Dimension.width10 / 2),
                child: ListView.builder(
                    itemCount: orderList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Order No.: ${orderList[index].id.toString()}'),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(
                                          Dimension.height10 / 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(
                                          Dimension.radius20 / 4,
                                        ),
                                      ),
                                      child: Text(
                                        '${orderList[index].orderStatus}',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(height: Dimension.height10 / 2),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            Dimension.height10 / 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            Dimension.radius20 / 4,
                                          ),
                                          border: Border.all(
                                            width: 1,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                        child: Text("Track Order"),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: Dimension.height10),
                          ],
                        ),
                      );
                    }),
              ),
            );
          } else {
            return Text("Loading");
          }
        },
      ),
    );
  }
}
