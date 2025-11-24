
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIService {
  static bool get isContextReady {
    return Get.context != null && Get.context!.mounted;
  }

  static void showSuccessSnackbar(String message) {
    _safeUiCall(() {
      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
      Get.rawSnackbar(
        title: "نجاح",
        message: message,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 2),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    });
  }

  static void showErrorSnackbar(String message) {
    _safeUiCall(() {
      if (Get.isSnackbarOpen) Get.closeAllSnackbars();
      Get.rawSnackbar(
        title: "خطأ",
        message: message,
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 8,
      );
    });
  }

  static void showSuccessDialog(String title, String message) {
    _safeUiCall(() {
      if (Get.isDialogOpen ?? false) return;
      Get.dialog(
        AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('حسناً'),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    });
  }

  static void _safeUiCall(Function callback) {
    if (isContextReady) {
      callback();
      return;
    }

    Future.delayed(const Duration(milliseconds: 100), () {
      if (isContextReady) callback();
      else print('⚠️ UI Context not ready for: $callback');
    });
  }
}
