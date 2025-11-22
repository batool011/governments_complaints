import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:governments_complaints/features/auth/presentation/widget/custom_label_text_field.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';

class ComplaintFromField extends StatelessWidget {
  ComplaintFromField({super.key});
  final controller = Get.find<ComplaintController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // نوع الشكوى 
        _buildComplaintTypeField(),
        const SizedBox(height: 16),

        // الجهة الحكومية 
        _buildGovernmentEntityField(),
        const SizedBox(height: 16),

        //الموقع
        _buildlocationfield(),
        const SizedBox(height: 16),

        // وصف المشكلة 
        _buildDescriptionField(),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildComplaintTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelTextField(text: "نوع الشكوى"),
        Obx(() => DropdownButtonFormField<String>(
          value: controller.selectedComplaintType.value.isEmpty ? null : controller.selectedComplaintType.value,
          items: controller.complaintTypes
              .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
              .toList(),
          onChanged: (value) {
            controller.selectedComplaintType.value = value!;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'اختر نوع الشكوى',
          ),
        )),
      ],
    );
  }

  Widget _buildGovernmentEntityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelTextField(text: "الجهة الحكومية"),
        Obx(() {
          if (controller.isLoadingCompanies.value) {
            return _buildLoadingIndicator();
          }
          
          if (controller.companies.isEmpty) {
            return _buildEmptyState();
          }
          
          return DropdownButtonFormField<String>(
            // التصحيح النهائي - تحقق بسيط من القيمة الفارغة فقط
            value: controller.selectedGovernmentEntity.value.isEmpty ? null : controller.selectedGovernmentEntity.value,
            items: controller.companies
                .map((company) => DropdownMenuItem(
                      value: company.name,
                      child: Text(company.name),
                    ))
                .toList(),
            onChanged: (value) {
              controller.selectedGovernmentEntity.value = value ?? '';
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "اختر الجهة الحكومية",
            ),
          );
        }),
      ],
    );
  }



  Widget _buildlocationfield(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

const CustomLabelTextField(text: "الموقع"),

Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
  decoration: BoxDecoration(
    color: Colors.grey.shade100,
    borderRadius: BorderRadius.circular(8),
    border: Border.all(color: Colors.grey.shade300),
  ),
  child: Row(
    children: [
      const Icon(
        Icons.location_on,
        color: AppColor.primaryColor,
        size: 28,
      ),
    const SizedBox(width: 10),
      Expanded(
        child: TextFormField(
           controller: controller.locationController,
              maxLines: 2,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(12),
                hintText: 'ادخل الموقع...',
              ),
        ),
      ),
  
      ],
  ))
  ]
  );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomLabelTextField(text: "وصف المشكلة"),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            controller: controller.descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
              hintText: 'صف المشكلة بالتفصيل...',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: const Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 8),
            Text(
              'جاري تحميل الجهات الحكومية...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text(
          'لا توجد جهات حكومية متاحة',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}