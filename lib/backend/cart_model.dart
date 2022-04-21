import 'dart:core';

import 'package:foodart/backend/popular_product_model.dart';

class CartModel {
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  ProductModel? product;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.time,
      this.product});

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    isExist = json['isExist'];
    time = json['time'];
    price = json['price'];
    img = json['img'];
    product = ProductModel.fromJson(json['product']);
  }
}
