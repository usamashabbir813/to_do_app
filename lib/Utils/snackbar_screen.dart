import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_app/constants/App_color.dart';
import 'package:to_do_app/constants/App_icon.dart';

class SnackbarUtil {
  static void showSuccess(String message, {String title = "Success"}) {
    _showSnackbar(title, message, AppColors.teal, AppIcon.checkCircle);
  }

  static void showError(String message, {String title = "Error"}) {
    _showSnackbar(title, message, AppColors.red, AppIcon.error);
  }

  static void showWarning(String message, {String title = "Warning"}) {
    _showSnackbar(title, message, AppColors.orange, AppIcon.warning);
  }

  static void _showSnackbar(
      String title, String message, Color color, IconData icon) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: color.withOpacity(.9),
      colorText: AppColors.white,
      icon: Icon(icon, color: AppColors.white),
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      forwardAnimationCurve: Curves.easeOutBack,
    );
  }
}
