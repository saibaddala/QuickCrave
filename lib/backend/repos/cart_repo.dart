import 'dart:convert';

import 'package:foodart/backend/app_constants.dart';
import 'package:foodart/backend/models/cart_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];
    for (CartModel element in cartList) {
      cart.add(jsonEncode(
        element,
      ));
    }
    sharedPreferences.setStringList(AppConstants.cartList, cart);
  }

  List<CartModel> getCartList() {
    List<String> cart = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      cart = sharedPreferences.getStringList(AppConstants.cartList)!;
    }
    List<CartModel> cartItems = [];
    for (var element in cart) {
      cartItems.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartItems;
  }
}
