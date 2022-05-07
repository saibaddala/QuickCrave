import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/auth_controller.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';
import 'package:foodart/reusable_widgets/custom_loading_screen.dart';
import 'package:foodart/reusable_widgets/custom_textfield_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../backend/models/server_auth_response_model.dart';
import '../reusable_widgets/custom_snackbar.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController mobileNumberTextController =
        TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();

    late String mobileNumber;
    late String password;

    bool checkSignInDetails() {
      mobileNumber = mobileNumberTextController.text.trim();
      password = passwordTextController.text.trim();

      if (mobileNumber.isEmpty) {
        showCustomSnackBar(message: "Mobile Number is required");
        return false;
      } else if (password.isEmpty) {
        showCustomSnackBar(message: "Password is required");
        return false;
      } else {
        return true;
      }
    }

    return GetBuilder<AuthController>(
      builder: ((authController) {
        return !authController.isLoading
            ? Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.all(Dimensions.width10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimensions.radius150,
                            backgroundImage: const AssetImage(
                                "assets/images/logo part 1.png"),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: Dimensions.width20),
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello",
                                style: TextStyle(
                                    fontSize: Dimensions.fontSize80,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "Sign into your account...",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.fontSize25),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        CustomTextFieldWidget(
                          textController: mobileNumberTextController,
                          hintText: "Mobile Number",
                          iconData: Icons.phone,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        CustomTextFieldWidget(
                          textController: passwordTextController,
                          hintText: "Password",
                          obscuretext: true,
                          iconData: Icons.key,
                        ),
                        SizedBox(
                          height: Dimensions.height20,
                        ),
                        GestureDetector(
                          onTap: () async {
                            if (checkSignInDetails()) {
                              ServerAuthResponseModel serverAuthResponseModel =
                                  await authController.loginUser(
                                      mobileNumber, password);
                              if (serverAuthResponseModel.isSuccess) {
                                Get.toNamed(RouteHelper.homeScreenRoute);
                              } else {
                                showCustomSnackBar(
                                    message: serverAuthResponseModel.message);
                              }
                            }
                          },
                          child: Container(
                            height: Dimensions.height60,
                            width: Dimensions.width160,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.height60 / 2),
                                color: AppColors.mainColor),
                            child: const Center(
                              child: BigText(
                                text: "SignIn",
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.height30,
                        ),
                        RichText(
                          text: TextSpan(
                              text: "Don't have an account?",
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: Dimensions.fontSize17),
                              children: [
                                TextSpan(
                                  text: "Create",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(RouteHelper.signUppageRoute);
                                    },
                                  style: TextStyle(
                                      color: AppColors.mainBlackColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Dimensions.fontSize20),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: Dimensions.height5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const CustomLoadingScreen();
      }),
    );
  }
}
