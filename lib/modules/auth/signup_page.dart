import 'package:flutter/material.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: Dimension.screenHeight * 0.05),
          Container(
            height: Dimension.screenHeight * 0.25,
            child: Center(
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/image/paju_logo.png"),
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                //hinttext
                hintText: "Email",
                // prefixicon,
                prefixIcon: Icon(
                  Icons.email,
                  color: AppColors.yellowColor,
                ),
                // focusedborder,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  borderSide: BorderSide(width: 1.0, color: Colors.white),
                ),

                // //enabledborder
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  borderSide: BorderSide(width: 1.0, color: Colors.white10),
                ),
                // //border
              ),
            ),
          ),
        ],
      ),
    );
  }
}
