import 'package:flutter/material.dart';
import 'package:foodart/screens/home_screen.dart';
import 'package:foodart/screens/popular_food_detail.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(
    const GetMaterialApp(
      home: PopularFoodDetail(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
