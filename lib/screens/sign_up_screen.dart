import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/auth_controller.dart';
import 'package:foodart/backend/models/sign_up_details_model.dart';
import 'package:foodart/backend/models/server_auth_response_model.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_loading_screen.dart';
import 'package:foodart/reusable_widgets/custom_snackbar.dart';
import 'package:foodart/reusable_widgets/custom_textfield_widget.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> socialMedia = ["t.png", "f.png", "g.png"];
    final TextEditingController emailTextController = TextEditingController();
    final TextEditingController passwordTextController =
        TextEditingController();
    final TextEditingController nameTextController = TextEditingController();
    final TextEditingController phoneTextController = TextEditingController();

    late String email;
    late String password;
    late String name;
    late String phone;

    bool checkSignUpDetails() {
      email = emailTextController.text.trim();
      password = passwordTextController.text.trim();
      name = nameTextController.text.trim();
      phone = phoneTextController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar(message: "Email is required");
        return false;
      } else if (password.isEmpty) {
        showCustomSnackBar(message: "Password is required");
        return false;
      } else if (name.isEmpty) {
        showCustomSnackBar(message: "Name is required");
        return false;
      } else if (phone.isEmpty) {
        showCustomSnackBar(message: "Phone number is required");
        return false;
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar(message: "Please enter a valid email");
        return false;
      } else if (!GetUtils.isPhoneNumber(phone)) {
        showCustomSnackBar(message: "Please enter a valid mobile number");
        return false;
      } else if (password.length < 6) {
        showCustomSnackBar(message: "Password is too weak");
        return false;
      } else {
        return true;
      }
    }

    SignUpDetailsModel getSignUpDetailsModelFromUi() {
      return SignUpDetailsModel(
        email: email,
        password: password,
        name: name,
        phone: phone,
      );
    }

    return GetBuilder<AuthController>(
      builder: ((authController) {
        return !authController.isLoading
            ? Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: Dimensions.radius120,
                          backgroundImage:
                              const AssetImage("assets/images/logo part 1.png"),
                        ),
                      ),
                      CustomTextFieldWidget(
                        textController: emailTextController,
                        hintText: "Email",
                        iconData: Icons.email,
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
                      CustomTextFieldWidget(
                          textController: nameTextController,
                          hintText: "Name",
                          iconData: Icons.person),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      CustomTextFieldWidget(
                        textController: phoneTextController,
                        hintText: "Phone",
                        iconData: Icons.phone,
                      ),
                      SizedBox(
                        height: Dimensions.height25,
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (checkSignUpDetails()) {
                            SignUpDetailsModel signUpDetailsModelFromUi =
                                getSignUpDetailsModelFromUi();
                            ServerAuthResponseModel signUpResponseFromServer =
                                await authController
                                    .registerUser(signUpDetailsModelFromUi);

                            if (signUpResponseFromServer.isSuccess) {
                            } else {
                              showCustomSnackBar(
                                  message: signUpResponseFromServer.message);
                            }
                          }
                        },
                        child: Container(
                          height: Dimensions.height60,
                          width: Dimensions.height160,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.height60 / 2),
                              color: AppColors.mainColor),
                          child: const Center(
                            child: BigText(
                              text: "SignUp",
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Have an account already?",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(RouteHelper.getSignInScreen());
                            },
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.fontSize15),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Or  ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.fontSize15),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height5,
                      ),
                      RichText(
                        text: TextSpan(
                          text: "SignUp with ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.fontSize15),
                        ),
                      ),
                      Wrap(
                        children: List.generate(
                          3,
                          (index) => Padding(
                            padding: EdgeInsets.all(Dimensions.width10),
                            child: CircleAvatar(
                              radius: Dimensions.radius15,
                              backgroundImage: AssetImage(
                                  "assets/images/" + socialMedia[index]),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            : const CustomLoadingScreen();
      }),
    );
  }
}
