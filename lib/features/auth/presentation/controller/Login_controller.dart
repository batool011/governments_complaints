// app/modules/auth/register/controllers/register_controller.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/cache/cach_helper.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/network/token_storage.dart';
import 'package:governments_complaints/core/routes/app_route.dart';
import 'package:governments_complaints/features/auth/data/repository/auth_repo.dart';

import '../../../../core/notification/push_notification_services.dart';

class LoginController extends GetxController {
  final AuthRepository repo =AuthRepository();
  final formKey = GlobalKey<FormState>();
  // المتغيرات الخاصة بالحقول
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // حالة إظهار/إخفاء كلمة المرور
  var isPasswordHidden = true.obs;

  // حالة التحميل
  var isLoading = false.obs;
  var errorMessage =''.obs;

  // تبديل ظهور كلمة المرور
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
  Future<void> login() async {
    errorMessage.value = '';
    isLoading.value = true;
     var deviceToken = await TokenStorage.getDeviceToken();
     print('device token: $deviceToken');

     if (deviceToken == null || deviceToken.isEmpty) {
      await Firebase.initializeApp();
      await FirebaseMessagingService().initNotificationsSettings();
       deviceToken = await TokenStorage.getDeviceToken();
       print('device token 2: $deviceToken');
    }

    try {
    
      final data ={
        "email": emailController.text,
        "password": passwordController.text,
        "fcm_token": deviceToken.toString(),
       
      };
     
      final result = await repo.login(data: data);

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          Get.log("Error: ${failure.statusCode} ${failure.message}");
          Get.snackbar(
            "Error",
            failure.message,
            backgroundColor: AppColor.red.withAlpha(80),
            colorText: AppColor.black,
          );
        },
        (response) {
          TokenStorage.saveToken(response.data['data']['token']);

          print(TokenStorage.getToken());
          Get.snackbar(
            "Succsess",
            response.statusMessage ??"Done",
            backgroundColor: AppColor.green.withAlpha(80),
            colorText: AppColor.black,
          );
          Get.log("Success: $response");

          Get.offAllNamed(Routes.home);
          // FirebaseMessagingService firebaseMessagingService =
          //     FirebaseMessagingService();
         // firebaseMessagingService.subscribeToTopic('all_vendors');
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
