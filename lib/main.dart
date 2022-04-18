import 'package:flutter/material.dart';
import 'package:foodart/backend/dependencies.dart' as dep;
import 'package:foodart/screens/home_screen.dart';
import 'package:foodart/screens/popular_food_detail_screen.dart';
import 'package:foodart/screens/recommended_food_detail_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.loadDependencies();
  runApp(
    const GetMaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
