import 'package:get/get.dart';
import 'package:governments_complaints/features/home/data/repo/complaint_repo.dart';
import 'package:governments_complaints/features/home/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
  
    Get.lazyPut<ComplaintRepo>(() => ComplaintRepo());


    Get.lazyPut<HomeStatsController>(
      () => HomeStatsController(repo: Get.find()),
    );
  }
}
