import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/controllers/order_controller.dart';
import 'package:food_delivery/models/order_model.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

import '../../base/no_data_page.dart';

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
            } else {
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.5,
                child: const Center(
                  child: NoDataPage(
                    text: "You did't buy anything at all!",
                    imgPath: "assets/image/empty_box.png",
                  ),
                ),
              );
            }
            return SizedBox(
              width: Dimension.screenWidth,
              child: Padding(
                padding: EdgeInsets.all(Dimension.width10),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: Dimension.width45 * 4,
                                      height: Dimension.height20,
                                      child: Text(
                                        'Order Date: ${orderList[index].createdAt.toString()}',
                                        style: TextStyle(
                                          overflow: TextOverflow.ellipsis,
                                          color: AppColors.mainBlackColor,
                                          fontSize: Dimension.font14,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Order No.: ${orderList[index].id.toString()}',
                                      style: TextStyle(
                                        color: AppColors.mainBlackColor,
                                        fontSize: Dimension.font14,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Dimension.height10,
                                        vertical: Dimension.height10 / 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.mainColor,
                                        borderRadius: BorderRadius.circular(
                                          Dimension.radius20 / 4,
                                        ),
                                      ),
                                      child: Text(
                                        '${orderList[index].orderStatus}',
                                        style: TextStyle(
                                            color: Theme.of(context).cardColor,
                                            fontSize: Dimension.font12),
                                      ),
                                    ),
                                    SizedBox(height: Dimension.height10 / 2),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Dimension.height10,
                                          vertical: Dimension.height10 / 2,
                                        ),
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
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/image/tracking.png",
                                              height: Dimension.height15,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            SizedBox(
                                                width: Dimension.width10 / 2),
                                            Text(
                                              "track order",
                                              style: TextStyle(
                                                fontSize: Dimension.font12,
                                                color: Theme.of(context)
                                                    .primaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
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
            return const CustomLoader();
          }
        },
      ),
    );
  }
}
