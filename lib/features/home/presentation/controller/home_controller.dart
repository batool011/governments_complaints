import 'package:get/get.dart';
import 'package:governments_complaints/core/routes/app_route.dart';
import 'package:governments_complaints/features/home/data/model/complaint_status_model.dart';
import 'package:governments_complaints/features/home/data/repo/complaint_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:governments_complaints/core/network/exceptions.dart';

import '../../../../core/network/token_storage.dart';

class HomeStatsController extends GetxController {
  final ComplaintRepo repo;

  HomeStatsController({required this.repo});

  var status = <ComplaintStatusModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchStats();
  }

  void fetchStats() async {
    try {
      isLoading.value = true;
      final Either<AppException, List<ComplaintStatusModel>> response =
          await repo.getStatus();

      response.fold(
        (l) => errorMessage.value = l.message,
        (r) => status.value = r,
      );
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
