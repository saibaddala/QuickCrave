import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';
import 'package:foodart/reusable_widgets/custom_textfield_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    return Scaffold(
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
                  backgroundImage:
                      const AssetImage("assets/images/logo part 1.png"),
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
                iconData: Icons.key,
              ),
              SizedBox(
                height: Dimensions.height20,
              ),
              Container(
                height: Dimensions.height60,
                width: Dimensions.width160,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(Dimensions.height60 / 2),
                    color: AppColors.mainColor),
                child: const Center(
                  child: BigText(
                    text: "SignIn",
                    textColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: Dimensions.height30,
              ),
              RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.fontSize17),
                    children: [
                      TextSpan(
                        text: "Create",
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
    );
  }
}
