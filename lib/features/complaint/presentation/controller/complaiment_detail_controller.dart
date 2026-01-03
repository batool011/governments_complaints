import 'package:get/get.dart';
import '../../data/models/detail_comlaint_model.dart';
import '../../data/repository/complaint_repository.dart';

class ComplaintDetailController extends GetxController {
   final ComplaintRepository repo =ComplaintRepository();

  var complaintsDetail = Rxn<ComplaintData>();
  var errorMessage = ''.obs;
  final isLoading = false.obs;
  late int complaintId;@override
  
void onInit() {
  super.onInit();
  complaintId = Get.arguments;
  getComplainsDetail(complaintId);
}



  Future<void> getComplainsDetail(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await repo.getComplaintDetail(id: id);

    result.fold(
          (failure) {
        errorMessage.value = failure.message;
        Get.snackbar('خطأ', failure.message);
        print("failure");
      },
          (response) {
        complaintsDetail.value = response.complaintData;
        print('bookingDetails.value!.id');
        print(complaintsDetail.value!.id);
      },
    );

    isLoading.value = false;
  }
  String? dd(String selectedStatu) {
    switch (selectedStatu) {
      case 1:
        return 'انتظار';
      case 2:
        return 'قيد المعالجة';
      case 3:
        return 'مكتمل';

    }
  }



}