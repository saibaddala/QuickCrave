import 'package:flutter/material.dart';
import 'package:foodart/backend/controllers/auth_controller.dart';
import 'package:foodart/backend/controllers/cart_controller.dart';
import 'package:foodart/backend/controllers/location_controller.dart';
import 'package:foodart/backend/controllers/user_controller.dart';
import 'package:foodart/reusable_widgets/account_detail_row_widget.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/custom_loading_screen.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:get/get.dart';
import '../utilities/colors.dart';
import '../utilities/dimensions.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isUserLoggedIn = Get.find<AuthController>().isuserLoggedIn();
    if (_isUserLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return GetBuilder<UserController>(
      builder: ((userController) {
        return _isUserLoggedIn
            ? (!userController.isLoading
                ? const CustomLoadingScreen()
                : Scaffold(
                    body: Column(
                      children: [
                        Container(
                          height: Dimensions.height150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft:
                                    Radius.circular(Dimensions.radius40),
                                bottomRight:
                                    Radius.circular(Dimensions.radius40)),
                            color: AppColors.mainColor,
                          ),
                          child: Center(
                            child: BigText(
                              text: "Profile",
                              textSize: Dimensions.fontSize30,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(top: Dimensions.height15),
                            width: double.maxFinite,
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: Dimensions.radius80,
                                          backgroundImage: const AssetImage(
                                              "assets/images/sai.png"),
                                        ),
                                        AccountDetailRowWidget(
                                            icon: Icons.person,
                                            fieldText:
                                                userController.userModel.name,
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        AccountDetailRowWidget(
                                            icon: Icons.call,
                                            fieldText:
                                                userController.userModel.phone,
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        AccountDetailRowWidget(
                                            icon: Icons.email,
                                            fieldText:
                                                userController.userModel.email,
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        GetBuilder<LocationController>(
                                          builder: ((locationController) {
                                            if (_isUserLoggedIn &&
                                                locationController
                                                    .addressList.isEmpty) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(RouteHelper
                                                      .addAddressPageRoute);
                                                },
                                                child:
                                                    const AccountDetailRowWidget(
                                                        icon:
                                                            Icons.location_city,
                                                        fieldText:
                                                            "Your Address",
                                                        containerbackgroundColor:
                                                            AppColors
                                                                .mainColor),
                                              );
                                            } else {
                                              return GestureDetector(
                                                onTap: () {
                                                  Get.toNamed(RouteHelper
                                                      .addAddressPageRoute);
                                                },
                                                child: AccountDetailRowWidget(
                                                    icon: Icons.location_city,
                                                    fieldText: locationController
                                                            .addressToDisplay
                                                            .substring(0, 15) +
                                                        "....",
                                                    overflowRequired: true,
                                                    containerbackgroundColor:
                                                        AppColors.mainColor),
                                              );
                                            }
                                          }),
                                        ),
                                        const AccountDetailRowWidget(
                                            icon: Icons.message,
                                            fieldText: "messages",
                                            containerbackgroundColor:
                                                AppColors.mainColor),
                                        GestureDetector(
                                          onTap: () {
                                            if (Get.find<AuthController>()
                                                .isuserLoggedIn()) {
                                              Get.find<AuthController>()
                                                  .clearAllUserDataWhileLoggingOut();
                                              Get.find<CartController>()
                                                  .clearAllUserCartDataWhileLoggingOut();
                                              Get.toNamed(RouteHelper
                                                  .getSignInScreen());
                                              Get.find<LocationController>()
                                                  .clearAddressList();
                                            }
                                          },
                                          child: const AccountDetailRowWidget(
                                            icon: Icons.logout,
                                            fieldText: "Logout",
                                            containerbackgroundColor:
                                                Colors.redAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            : Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width -
                            Dimensions.width50,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/signintocontinue.png"),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getSignInScreen());
                        },
                        child: Container(
                          height: Dimensions.height75,
                          width: Dimensions.width180,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.mainColor),
                          child: const Center(
                            child: BigText(
                              text: "Sign In",
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}
