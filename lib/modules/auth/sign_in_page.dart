import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/base/custom_loader.dart';
import 'package:food_delivery/common/app_text_field.dart';
import 'package:food_delivery/common/customtext.dart';
import 'package:food_delivery/modules/auth/sign_up_page.dart';
import 'package:food_delivery/routes/routes.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimension.dart';
import 'package:get/get.dart';
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var signUpImages = [
      "t.png",
      "f.png",
      "g.png",
    ];
    void _login(AuthController authController) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Enter email address",
            title: "Email address required!");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Enter a valid email address",
            title: "Invalid email address!");
      } else if (password.isEmpty) {
        showCustomSnackBar("Enter password", title: "Password required!");
      } else {
        authController.login(email, password).then((status) {
          if (status.isSuccess) {
            Get.toNamed(AppRoutes.getCartPage());
          } else {
            showCustomSnackBar(status.message);
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (authController) {
        return !authController.isLoading
            ? SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(height: Dimension.screenHeight * 0.05),
                    SizedBox(
                      height: Dimension.screenHeight * 0.25,
                      child: const Center(
                        child: CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage("assets/image/paju_logo.png"),
                        ),
                      ),
                    ),
                    // SizedBox(height: Dimension.screenHeight * 0.05),
                    Container(
                      margin: EdgeInsets.only(left: Dimension.width20),
                      width: double.maxFinite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "Welcome",
                            color: AppColors.mainColor,
                            fontSize: Dimension.font26,
                          ),
                          SizedBox(height: Dimension.screenHeight * 0.02),
                          CustomText(
                            text: "Sign in to your account",
                            color: Colors.grey[500],
                            fontSize: Dimension.font14 * 1.2,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: Dimension.screenHeight * 0.02),
                    //login fields
                    AppTextField(
                      textController: emailController,
                      hintText: "Email",
                      icon: Icons.email,
                    ),
                    SizedBox(height: Dimension.height30),
                    AppTextField(
                      textController: passwordController,
                      hintText: "Password",
                      icon: Icons.password_sharp,
                      isObscure: true,
                    ),
                    SizedBox(height: Dimension.height20),

                    //signup button
                    GestureDetector(
                      onTap: () {
                        _login(authController);
                      },
                      child: Container(
                        width: Dimension.screenWidth / 3,
                        height: Dimension.screenHeight / 15,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimension.radius30),
                          color: AppColors.mainColor,
                        ),
                        child: Center(
                          child: CustomText(
                            text: "Sign In",
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
                        text: "Don't have an account?",
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimension.font14,
                        ),
                        children: [
                          TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Get.to(() => const SignUpPage(),
                                  transition: Transition.fade),
                            text: " Create",
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
                            backgroundImage: AssetImage(
                                "assets/image/" + signUpImages[index]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const CustomLoader();
      }),
    );
  }
}
