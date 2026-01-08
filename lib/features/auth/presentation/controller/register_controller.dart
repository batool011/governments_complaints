// app/modules/auth/register/controllers/register_controller.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/network/token_storage.dart';
import 'package:governments_complaints/core/routes/app_route.dart';
import 'package:governments_complaints/features/auth/data/repository/auth_repo.dart';

import '../../../../core/notification/push_notification_services.dart';
import '../../../../core/snak_bar_service.dart';


class RegisterController extends GetxController {
  //public
  final AuthRepository repo = AuthRepository();
  final formKey = GlobalKey<FormState>();

  // المتغيرات الخاصة بالحقول
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController =TextEditingController();
  final phoneController =TextEditingController();
  // حالة إظهار/إخفاء كلمة المرور
  var isPasswordHidden = true.obs;

  // حالة التحميل
  var isLoading = false.obs;
  var errorMessage =''.obs;

  // تبديل ظهور كلمة المرور
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }
 Future<void> register() async {
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
      // MultipartFile? profileImageFile;
      // if (selectedImage.value != null) {
      //   profileImageFile = await MultipartFile.fromFile(
      //     selectedImage.value!.path,
      //     filename: selectedImage.value!.path.split('/').last,
      //   );
      // }

      // List<MultipartFile> multipartFiles = [];
      // for (var path in selectedFilePaths) {
      //   multipartFiles.add(
      //     await MultipartFile.fromFile(path, filename: path.split('/').last),
      //   );
      // }

      final data ={
        "fullname":fullNameController.text,
        "username":nameController.text,
        "email": emailController.text,
        "phone":phoneController.text,
        "password": passwordController.text,
        "password_confirmation":confirmPasswordController.text,
        "fcm_token": deviceToken.toString(),
       
      };
      
      final result = await repo.register(data: data);

      result.fold(
        (failure) {
          errorMessage.value = failure.message;
          Get.log("Error: ${failure.statusCode} ${failure.message}");
          SnackbarService.success(failure.message);

        },
        (response) {
           print("TokenStorage.getToken()");
           TokenStorage.saveToken(response.data['data']['token']);

             print(TokenStorage.getToken());
           SnackbarService.success("تم تسجيل الدخول بنجاح");

           Get.log("Success: $response");
          // TokenStorage.saveUserId(response.data['data']['user_id']);
          // TokenStorage.saveToken(response.data['token']);

          Get.offAllNamed(Routes.otpScreen);
          // FirebaseMessagingService firebaseMessagingService =
          //     FirebaseMessagingService();
         // firebaseMessagingService.subscribeToTopic('all_vendors');
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    phoneController.dispose();
    fullNameController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
