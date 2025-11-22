import 'package:get/get.dart';
import '../controller/Login_controller.dart';
import '../controller/otp_controller.dart';
import '../controller/register_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<OtpController>(() => OtpController());
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
