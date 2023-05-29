import 'package:flutter/material.dart';
import 'package:food_delivery/common/app_icon.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/utils/colors.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var getCartHistoryList =

    // Map<String, int> cartItemsPerOrder = Map();
    // for (int i = 0; i < getCartHistoryList.length; i++) {
    //   if (cartItemsPerOrder.containsKey(getCartHistoryList[i]["time"])) {
    //     cartItemsPerOrder.update(
    //         getCartHistoryList[i]["time"], (value) => ++value);
    //   } else {
    //     cartItemsPerOrder.putIfAbsent(getCartHistoryList[i]["time"], () => 1);
    //   }
    // }
    // List<int> cartOrderTimeToList() {
    //   return cartItemsPerOrder.entries.map((e) => e.value).toList();
    // }

    // List<int> orderTimes = cartOrderTimeToList();

    // var saveCounter = 0;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: AppColors.mainColor,
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 45, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Cart History",
                  fontSize: 20,
                  color: Colors.white,
                ),
                const AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
