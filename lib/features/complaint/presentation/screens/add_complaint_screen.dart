import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constant/class/app_color.dart';
import '../../../../core/utils/custom_button.dart';
import '../../../auth/presentation/widget/custom_label_text_field.dart';
import '../controller/compaint_controller.dart';
import '../widgets/attached_file_list.dart';
import '../widgets/complaint_from_field.dart';
class AddComplaintScreen extends GetView<ComplaintController> {
  const AddComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


 //زر تقديم الشكوى 
 Obx(()=>controller.isLoading.value
 ?Center(child: CircularProgressIndicator(),)
 :SizedBox(
                      width: double.infinity,
                      child: CustomButton(
                        onPressed: controller.submitComplaint,
                        text: 'تقديم الشكوى',
                      ),)

 )

    ],
  ),
),
)
    );
  }
}