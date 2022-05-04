import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';
import 'package:foodart/reusable_widgets/custom_textfield_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 120,
                  backgroundImage: AssetImage("assets/images/logo part 1.png"),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style:
                          TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Sign into your account...",
                      style: TextStyle(color: Colors.grey[500], fontSize: 25),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextFieldWidget(
                textController: emailTextController,
                hintText: "Email",
                iconData: Icons.email,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextFieldWidget(
                textController: passwordTextController,
                hintText: "Password",
                iconData: Icons.key,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60 / 2),
                    color: AppColors.mainColor),
                child: Center(
                    child: BigText(
                  text: "SignIn",
                  textColor: Colors.white,
                )),
              ),
              SizedBox(
                height: 30,
              ),
              RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(color: Colors.grey[500], fontSize: 17),
                    children: [
                      TextSpan(
                          text: "Create",
                          style: TextStyle(
                              color: AppColors.mainBlackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 22))
                    ]),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
