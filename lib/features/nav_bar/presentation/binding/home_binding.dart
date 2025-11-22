import 'package:get/get.dart';
import 'package:governments_complaints/features/auth/presentation/controller/otp_controller.dart';
import 'package:governments_complaints/features/auth/presentation/controller/Login_controller.dart';
import 'package:governments_complaints/features/auth/presentation/controller/register_controller.dart';
import 'package:governments_complaints/features/nav_bar/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
