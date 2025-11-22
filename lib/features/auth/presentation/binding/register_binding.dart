// app/modules/auth/login/bindings/login_binding.dart
import 'package:get/get.dart';
import 'package:governments_complaints/features/auth/presentation/controller/otp_controller.dart';
import 'package:governments_complaints/features/auth/presentation/controller/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<OtpController>(() => OtpController());
  }
}
