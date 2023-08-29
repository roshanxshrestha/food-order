import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/show_custom_snackbar.dart';
import 'package:food_delivery/common/app_text_field.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/models/signup_body_model.dart';
import 'package:food_delivery/modules/auth/sign_in_page.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var rePasswordController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _registration() {
      var authController = Get.find<AuthController>();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      String repassword = rePasswordController.text.trim();

      if (name.isEmpty) {
        showCustomSnackBar("Enter name", title: "Name required!");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Enter phone number",
            title: "Phone number required!");
      } else if (email.isEmpty) {
        showCustomSnackBar("Enter email address",
            title: "Email address required!");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Enter a valid email address",
            title: "Invalid email address!");
      } else if (password.isEmpty) {
        showCustomSnackBar("Enter password", title: "Password required!");
      } else if (password.length < 6) {
        showCustomSnackBar("Password cannot be less than 6 characters",
            title: "Password error!");
      } else if (password != repassword) {
        showCustomSnackBar("Passwords doesn't match", title: "Password error!");
      } else {
        showCustomSnackBar("Good to go", title: "Perfect");
        SignUpBody signUpBody = SignUpBody(
          name: name,
          phone: phone,
          email: email,
          password: password,
        );
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            debugPrint("Success registration");
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: Dimension.screenHeight * 0.05),
            SizedBox(
              height: Dimension.screenHeight * 0.25,
              child: const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/image/paju_logo.png"),
                ),
              ),
            ),
            AppTextField(
              textController: nameController,
              hintText: "Name",
              icon: Icons.person,
            ),

            SizedBox(height: Dimension.height20),
            AppTextField(
              textController: phoneController,
              hintText: "Phone",
              icon: Icons.phone,
            ),

            SizedBox(height: Dimension.height20),
            AppTextField(
              textController: emailController,
              hintText: "Email",
              icon: Icons.email,
            ),
            SizedBox(height: Dimension.height20),
            AppTextField(
              textController: passwordController,
              hintText: "Password",
              icon: Icons.password_sharp,
            ),
            SizedBox(height: Dimension.height20),
            AppTextField(
              textController: rePasswordController,
              hintText: "Re-enter Password",
              icon: Icons.password_sharp,
            ),
            SizedBox(height: Dimension.height30),

            //signup button
            GestureDetector(
              onTap: () {
                _registration();
              },
              child: Container(
                width: Dimension.screenWidth / 3,
                height: Dimension.screenHeight / 15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimension.radius30),
                  color: AppColors.mainColor,
                ),
                child: Center(
                  child: CustomText(
                    text: "Sign Up",
                    color: Colors.white,
                    fontSize: Dimension.font20,
                  ),
                ),
              ),
            ),
            //have an account already
            SizedBox(height: Dimension.height20),
            RichText(
              text: TextSpan(
                text: "Already have an account?",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimension.font14,
                ),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Get.to(() => const SignInPage(),
                          transition: Transition.fade),
                    text: " Sign in",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: Dimension.font14,
                    ),
                  ),
                ],
              ),
            ),

            //signup using
            SizedBox(height: Dimension.screenHeight * 0.02),
            RichText(
              text: TextSpan(
                text: "Sign up using",
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: Dimension.font14,
                ),
              ),
            ),
            SizedBox(height: Dimension.screenHeight * 0.01),

            Wrap(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.all(Dimension.screenWidth * 0.02),
                  child: CircleAvatar(
                    radius: Dimension.radius20,
                    backgroundImage:
                        AssetImage("assets/image/" + signUpImages[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
