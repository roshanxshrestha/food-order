import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/modules/account/account_page.dart';
import 'package:food_delivery/modules/cart/cart_history.dart';
import 'package:food_delivery/modules/home_page/main_page.dart';
import 'package:food_delivery/modules/order/order_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../common/customtext.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';
import '../../routes/routes.dart';
import '../../utils/dimension.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  late List<Widget> _screens;
  late List<PersistentBottomNavBarItem> _navBarItems;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    _screens = _buildScreens();
    _navBarItems = _navBarsItems();

    super.initState();
  }

  void onTapNav(int index) {
    setState(() {});
  }

  List<Widget> _buildScreens() {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return [
      const MainPage(),
      _userLoggedIn
          ? const OrderPage()
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimension.height30 * 5,
                    margin: EdgeInsets.symmetric(horizontal: Dimension.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimension.radius20),
                      image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/signintocontinue.png"),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimension.screenHeight * 0.02),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.signIn);
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: Dimension.height45,
                      margin:
                          EdgeInsets.symmetric(horizontal: Dimension.width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(Dimension.radius15),
                      ),
                      child: Center(
                        child: CustomText(
                          text: "Sign in to see Order History",
                          color: Colors.white,
                          fontSize: Dimension.font20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      const CartHistory(),
      const AccountPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.archive_outlined),
        title: ("Archive"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart_outlined),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline),
        title: ("Profile"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  // Function to show the pop-up alert

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _screens,
      items: _navBarItems,
    );
  }
}
