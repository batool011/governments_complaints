import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/features/complaint/data/models/detail_comlaint_model.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';
import 'package:governments_complaints/features/complaint/presentation/widgets/custom_container_detail.dart';
import 'package:governments_complaints/features/complaint/presentation/widgets/statue_card.dart';
import '../widgets/image_list_view.dart';

class DetailComplaintScreen extends GetView<ComplaintsController> {
  const DetailComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
  final int complaintId = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('تفاصيل الشكوى',style: TextStyle(color: AppColor.white),textAlign: TextAlign.end,),
        backgroundColor: AppColor.primaryColor,
      ),
      body: Obx((){
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(

          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  StatueCard(status: 'status'),
                  Text(' : حالة الشكوى'),
                ],),
            ),
            CustomContainerDetail(txt1: ': نوع الشكوى', txt2: '',),
            CustomContainerDetail(txt1: ': الجهة', txt2: '',),
            CustomContainerDetail(txt1: ': الموقع', txt2: '',),
            CustomContainerDetail(txt1: ': وصف المشكلة', txt2: '',),
           // ImagesListView(images: [],)
          ],
        );
      })
    );
  }
}
