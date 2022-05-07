import 'package:flutter/material.dart';
import 'package:foodart/reusable_widgets/big_text.dart';
import 'package:get/get.dart';

void showCustomSnackBar(
    {required String message, bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        textColor: Colors.white,
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: isError ? Colors.redAccent : Colors.greenAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP);
}
