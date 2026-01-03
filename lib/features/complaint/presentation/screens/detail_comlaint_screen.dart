import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/features/complaint/data/models/detail_comlaint_model.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/complaiment_detail_controller.dart';
import 'package:governments_complaints/features/complaint/presentation/widgets/custom_container_detail.dart';
import 'package:governments_complaints/features/complaint/presentation/widgets/statue_card.dart';
import '../widgets/image_list_view.dart';

class DetailComplaintScreen extends GetView<ComplaintDetailController> {
  const DetailComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final int complaintId = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الشكوى',style: TextStyle(color: AppColor.white),textAlign: TextAlign.end,),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Obx(() {
  if (controller.isLoading.value) {
    return const Center(child: CircularProgressIndicator());
  }

  final data = controller.complaintsDetail.value;

  if (data == null) {
    return const Center(child: Text('لا توجد بيانات'));
  }

  return Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      children: [
        CustomContainerDetail(
          txt1: ': نوع الشكوى',
          txt2: data.type ?? '',
        ),
        CustomContainerDetail(
          txt1: ': الجهة',
          txt2: data.company?.name ?? '',
        ),
        CustomContainerDetail(
          txt1: ': الموقع',
          txt2: data.location ?? '',
        ),
        CustomContainerDetail(
          txt1: ': وصف المشكلة',
          txt2: data.description ?? '',
        ),
      ],
    ),
  );
}),

    );
  }
}
