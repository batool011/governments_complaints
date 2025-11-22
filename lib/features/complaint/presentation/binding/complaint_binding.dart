import 'package:get/get.dart';
import '../../data/repository/complaint_repository.dart';
import '../controller/compaint_controller.dart';

class ComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintRepository>(() => ComplaintRepository());
    Get.lazyPut(() => ComplaintController(Get.find<ComplaintRepository>()));
  }
}