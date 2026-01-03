import 'package:get/get.dart';
import 'package:governments_complaints/features/complaint/data/repository/complaint_repository.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/complaiment_detail_controller.dart';

class ComplaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComplaintRepository>(() => ComplaintRepository());
    Get.lazyPut<ComplaintsController>(
      () => ComplaintsController(Get.find<ComplaintRepository>()),
      fenix: true, 
    );
       Get.lazyPut<ComplaintDetailController>(() => ComplaintDetailController());
    

    //Get.lazyPut<RegisterController>(() => RegisterController());

  }
}