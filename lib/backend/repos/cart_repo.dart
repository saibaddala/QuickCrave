import 'dart:convert';
import 'package:foodart/backend/app_constants.dart';
import 'package:foodart/backend/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> notCheckedOutCartList = [];
  List<String>? cartHistoryList = [];

  void addToCartList(List<CartModel> items) {
    notCheckedOutCartList = [];
    var timeNow = DateTime.now().toString();
    for (var element in items) {
      element.time = timeNow;
      notCheckedOutCartList.add(jsonEncode(element));
    }

    sharedPreferences.setStringList(
        AppConstants.storedCartListBcozNotCheckedOut, notCheckedOutCartList);
  }

  List<CartModel> getStoredCartList() {
    List<String> storedCartListString = [];
    if (sharedPreferences
        .containsKey(AppConstants.storedCartListBcozNotCheckedOut)) {
      storedCartListString = sharedPreferences
          .getStringList(AppConstants.storedCartListBcozNotCheckedOut)!;
    }
    List<CartModel> storedCartList = [];
    for (var element in storedCartListString) {
      storedCartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    return storedCartList;
  }

  void addItemsToCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistoryList =
          sharedPreferences.getStringList(AppConstants.cartHistoryList);
    }
    for (var element in notCheckedOutCartList) {
      cartHistoryList!.add(element);
    }

    sharedPreferences.setStringList(
        AppConstants.cartHistoryList, cartHistoryList!);
    notCheckedOutCartList = [];
  }

  void removeNotCheckedOutCartList() {
    sharedPreferences.remove(AppConstants.storedCartListBcozNotCheckedOut);
  }

  List<CartModel> getCartHistoryListFromRepo() {
    List<String> cartHistoryItemsString = [];
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      cartHistoryItemsString =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    List<CartModel> cartHistoryItems = [];
    for (var element in cartHistoryItemsString) {
      cartHistoryItems.add(CartModel.fromJson(jsonDecode(element)));
    }
    return cartHistoryItems;
  }

  void clearAllUserCartDataStoredLocally() {
    removeNotCheckedOutCartList();
    sharedPreferences.remove(AppConstants.cartHistoryList);
  }
}
