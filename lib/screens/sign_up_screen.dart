import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_icon_widget.dart';
import 'package:foodart/reusable_widgets/custom_textfield_widget.dart';
import 'package:foodart/utilities/colors.dart';

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
        physics: BouncingScrollPhysics(),
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
            CustomTextFieldWidget(
                textController: nameTextController,
                hintText: "Name",
                iconData: Icons.person),
            SizedBox(
              height: 20,
            ),
            CustomTextFieldWidget(
              textController: phoneTextController,
              hintText: "Phone",
              iconData: Icons.phone,
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              height: 60,
              width: 160,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60 / 2),
                  color: AppColors.mainColor),
              child: Center(
                  child: BigText(
                text: "SignUp",
                textColor: Colors.white,
              )),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
                text: TextSpan(
                    text: "Have an account already?",
                    recognizer: TapGestureRecognizer()..onTap = () {},
                    style: TextStyle(color: Colors.grey[500], fontSize: 15))),
            SizedBox(
              height: 5,
            ),
            RichText(
                text: TextSpan(
                    text: "Or  ",
                    style: TextStyle(color: Colors.grey[500], fontSize: 15))),
            SizedBox(
              height: 5,
            ),
            RichText(
                text: TextSpan(
                    text: "SignUp with ",
                    style: TextStyle(color: Colors.grey[500], fontSize: 15))),
            Wrap(
              children: List.generate(
                  3,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage("assets/images/" + socialMedia[index]),
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
