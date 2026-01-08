import 'package:get/get.dart';
import 'package:governments_complaints/core/snak_bar_service.dart';
import 'package:governments_complaints/features/notification/data/repository/notification_repository.dart';

import '../../data/model/noti_model.dart';

class NotificationsController extends GetxController {
  final NotificationRepository repo = NotificationRepository();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var notifications = <NotiModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    getNotifications();
  }

  Future<void> getNotifications() async {
    errorMessage.value = '';
    isLoading.value = true;

    try {
      final result = await repo.getNoti();

      result.fold(
            (failure) {
          errorMessage.value = failure.message;
          SnackbarService.error(failure.message);
        },
            (response) {
          final List list = response.data;

          notifications.value =
              list.map((e) => NotiModel.fromJson(e)).toList();
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
