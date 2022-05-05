import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_textfield_widget.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> socialMedia = ["t.png", "f.png", "g.png"];
    final emailTextController = TextEditingController();
    final passwordTextController = TextEditingController();
    final nameTextController = TextEditingController();
    final phoneTextController = TextEditingController();
    return Scaffold(
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
            Container(
              height: Dimensions.height60,
              width: Dimensions.height160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.height60 / 2),
                  color: AppColors.mainColor),
              child: const Center(
                child: BigText(
                  text: "SignUp",
                  textColor: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: Dimensions.height10,
            ),
            RichText(
              text: TextSpan(
                text: "Have an account already?",
                recognizer: TapGestureRecognizer()..onTap = () {},
                style: TextStyle(
                    color: Colors.grey[500], fontSize: Dimensions.fontSize15),
              ),
            ),
            SizedBox(
              height: Dimensions.height5,
            ),
            RichText(
              text: TextSpan(
                text: "Or  ",
                style: TextStyle(
                    color: Colors.grey[500], fontSize: Dimensions.fontSize15),
              ),
            ),
            SizedBox(
              height: Dimensions.height5,
            ),
            RichText(
              text: TextSpan(
                text: "SignUp with ",
                style: TextStyle(
                    color: Colors.grey[500], fontSize: Dimensions.fontSize15),
              ),
            ),
            Wrap(
              children: List.generate(
                3,
                (index) => Padding(
                  padding: EdgeInsets.all(Dimensions.width10),
                  child: CircleAvatar(
                    radius: Dimensions.radius15,
                    backgroundImage:
                        AssetImage("assets/images/" + socialMedia[index]),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
