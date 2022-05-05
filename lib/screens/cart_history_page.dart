import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:foodart/reusable_widgets/image_and_text_widget.dart';
import 'package:foodart/reusable_widgets/small_text.dart';
import 'package:foodart/utilities/colors.dart';
import 'package:foodart/utilities/dimensions.dart';
import 'package:foodart/utilities/route_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../backend/app_constants.dart';
import '../backend/controllers/cart_controller.dart';
import '../backend/models/cart_model.dart';

class CartHistoryPage extends StatelessWidget {
  const CartHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cartItemsHistory =
        Get.find<CartController>().getCartHistoryList().reversed.toList();
    Map<String, int> cartItemsAddedAtSpecificTime = {};

    for (int i = 0; i < cartItemsHistory.length; i++) {
      if (cartItemsAddedAtSpecificTime.containsKey(cartItemsHistory[i].time)) {
        cartItemsAddedAtSpecificTime.update(
            cartItemsHistory[i].time!, (value) => ++value);
      } else {
        cartItemsAddedAtSpecificTime.putIfAbsent(
            cartItemsHistory[i].time!, () => 1);
      }
    }

    List<int> orderedItemsCountList() {
      return cartItemsAddedAtSpecificTime.entries.map((e) => e.value).toList();
    }

    List<String> atWhatTimeAddedTocart() {
      return cartItemsAddedAtSpecificTime.entries.map((e) => e.key).toList();
    }

    List<int> orderedItemsCount = orderedItemsCountList();

    List<String> cartListItemsOrderedTime = atWhatTimeAddedTocart();
    int k = 0;
    int x = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < cartItemsHistory.length) {
        var parseDate =
            DateFormat("yyyy-MM-dd HH:mm:ss").parse(cartItemsHistory[x].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM-dd-yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }

    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: GestureDetector(
        onTap: () {},
        child: Container(
          height: Dimensions.height50,
          width: Dimensions.width50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mainColor,
          ),
          child: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.mainColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(Dimensions.radius35),
              bottomRight: Radius.circular(Dimensions.radius35),
            ),
          ),
          padding: EdgeInsets.only(top: Dimensions.height40),
          width: double.maxFinite,
          height: Dimensions.height130,
          child: Center(
            child: BigText(
              text: "Cart History",
              textColor: Colors.white,
              textSize: Dimensions.fontSize30,
            ),
          ),
        ),
        MediaQuery.removePadding(
          context: context,
          child: GetBuilder<CartController>(
            builder: (controller) {
              return controller.getCartHistoryList().isNotEmpty
                  ? Expanded(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: Dimensions.width25,
                            right: Dimensions.width25,
                            top: Dimensions.height5,
                            bottom: Dimensions.height10),
                        child: ListView(
                          children: [
                            for (int i = 0;
                                i < cartItemsAddedAtSpecificTime.length;
                                i++)
                              Container(
                                margin:
                                    EdgeInsets.only(top: Dimensions.height10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    timeWidget(k),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            direction: Axis.horizontal,
                                            children: List.generate(
                                                orderedItemsCount[k] > 3
                                                    ? 3
                                                    : orderedItemsCount[k],
                                                (index) {
                                              return Container(
                                                  margin: EdgeInsets.only(
                                                      top: Dimensions.height5,
                                                      right: Dimensions.width5,
                                                      bottom:
                                                          Dimensions.height10),
                                                  height: Dimensions.height80,
                                                  width: Dimensions.width80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            Dimensions
                                                                .radius20),
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                            AppConstants
                                                                    .baseUrl +
                                                                AppConstants
                                                                    .uploadUrl +
                                                                cartItemsHistory[
                                                                        x++]
                                                                    .img!),
                                                        fit: BoxFit.cover),
                                                  ));
                                            }),
                                          ),
                                          (() {
                                            if (orderedItemsCount[k] > 3) {
                                              x = x + orderedItemsCount[k] - 3;
                                              return const SmallText(
                                                  text: "and more....");
                                            } else {
                                              return const Text("");
                                            }
                                          }()),
                                          SizedBox(
                                            height: Dimensions.height80,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SmallText(text: "Total"),
                                                BigText(
                                                    text: orderedItemsCount[k++]
                                                            .toString() +
                                                        " Items"),
                                                GestureDetector(
                                                  onTap: () {
                                                    Map<int, CartModel>
                                                        itemsTobeOrderedAgain =
                                                        {};
                                                    for (var element
                                                        in cartItemsHistory) {
                                                      if (element.time ==
                                                          cartListItemsOrderedTime[
                                                              i]) {
                                                        itemsTobeOrderedAgain
                                                            .putIfAbsent(
                                                                element.id!,
                                                                () {
                                                          return element;
                                                        });
                                                      }
                                                    }
                                                    Get.find<CartController>()
                                                        .addToCartListFromPastOrder(
                                                            itemsTobeOrderedAgain);

                                                    Get.toNamed(RouteHelper
                                                        .getCartPage());
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                Dimensions
                                                                    .radius10),
                                                        border: Border.all(
                                                            color: AppColors
                                                                .mainColor,
                                                            width: 1)),
                                                    child: SmallText(
                                                      text: "Reorder",
                                                      textColor: AppColors
                                                          .mainBlackColor,
                                                      textSize:
                                                          Dimensions.fontSize10,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ])
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: SizedBox(
                        height: Dimensions.height350,
                        child: const Center(
                          child: ImageAndTextWidget(
                            textToDisplay: "You didn't buy anything yet",
                            imagePath: "assets/images/empty_box.png",
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      ]),
    );
  }
}
