import 'dart:async';
import 'package:get/get.dart' hide FormData;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/core/network/token_storage.dart';
import 'package:governments_complaints/features/auth/data/repository/auth_repo.dart';

class OtpController extends GetxController {
  final codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final remainingSeconds = 120.obs;
  final AuthRepository repo = AuthRepository();
  var isLoading = false.obs;
  var errorMessage = ''.obs;
   var otpCode = ''.obs;

  //String? email = '';
  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>?;
   // email = arguments?['email'] ?? '';
    startCountdown();
  }

  void startCountdown() {
    _timer?.cancel();
    remainingSeconds.value = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTime {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}s';
  }

  Future<void> checkOtpCode() async {
  //  if (formKey.currentState!.validate()) {
      errorMessage.value = '';
      isLoading.value = true;

      final data={
        "code": otpCode.value,
      };
      try {
        final result = await repo.checkOtpCode(data: data);

        result.fold(
          (failure) {
            errorMessage.value = failure.message;
            Get.log("Error: ${failure.statusCode} ${failure.message}");
             print("TokenStorage.getToken()");
             print(TokenStorage.getToken().toString());
            Get.snackbar(
              "Error",
              failure.message,
              backgroundColor: AppColor.red.withAlpha(80),
              colorText: AppColor.black,
            );
          },
          (response) {
            print("TokenStorage.getToken()");
             print(TokenStorage.getToken());
            Get.log("Success: $response");
           
          },
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

//}
