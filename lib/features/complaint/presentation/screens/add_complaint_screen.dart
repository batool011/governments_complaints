import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/routes/app_route.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';


import '../../../../core/constant/class/app_color.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../auth/presentation/widget/custom_label_text_field.dart';

import '../widgets/attached_file_list.dart';
import '../widgets/complaint_from_field.dart';
class AddComplaintScreen extends GetView<ComplaintsController> {
  const AddComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:AppColor.secondaryColor,
appBar: AppBar(
  backgroundColor: AppColor.primaryColor,
  centerTitle: true,
  title: Text("تقديم شكوى ",style: TextStyle(color: AppColor.greyf,),

),),
body: Padding(padding: const EdgeInsets.all(16),
child: SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      //الحقول
 ComplaintFromField(),


 //المرفقات
 const CustomLabelTextField(text: "المرفقات (اختياري)"),
 const AttachedFilesList(),
 SizedBox(height: 32),
 Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('جاري المعالجة...'),
            ],
          ),
        );
      }

      return Column(
        children: [
          if (controller.isEditing.value) ...[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
              controller.updateComplaint();
                  // Get.toNamed(Routes.ComplaintsScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'تحديث الشكوى',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: (){
controller.cancelEditing();
Get.toNamed(Routes.ComplaintsScreen);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Colors.grey),
                ),
                child: const Text(
                  'إلغاء التعديل',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ] else ...[ 
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: (){
                  controller.submitComplaint();
               
                },
                 
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'إرسال الشكوى',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ],
      );
    })




    ],
  ),
),
)
    );
  }
}