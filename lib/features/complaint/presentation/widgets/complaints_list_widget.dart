import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';

import '../../data/models/complaint_model.dart';
import '../controller/compaint_controller.dart';

class ComplaintsListWidget extends GetView<ComplaintsController> {
  const ComplaintsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingComplaints.value && controller.complaintsList.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text(
                'جاري تحميل الشكاوى...',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        );
      }

      if (controller.complaintsList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.report_problem, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'لا توجد شكاوى',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              if (_hasError(context))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'حدث خطأ في تحميل الشكاوى',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red.shade600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: controller.refreshComplaints,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('إعادة المحاولة'),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshComplaints,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.complaintsList.length + 1,
          itemBuilder: (context, index) {
            if (index == controller.complaintsList.length) {
              if (controller.hasMoreComplaints.value) {
                // تحميل تلقائي للمزيد من البيانات
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  controller.loadMoreComplaints();
                });

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: controller.isLoadMore.value
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: controller.loadMoreComplaints,
                            child: const Text('تحميل المزيد'),
                          ),
                  ),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: Text(
                      'تم عرض جميع الشكاوى',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                );
              }
            }

            final complaint = controller.complaintsList[index];
            return _buildComplaintCard(complaint, index);
          },
        ),
      );
    });
  }

  bool _hasError(BuildContext context) {
    return false;
  }

  Widget _buildComplaintCard(ComplaintModel complaint, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  complaint.type,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '#${complaint.id}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // الجهة
            if (complaint.company != null) ...[
              Row(
                children: [
                  const Icon(Icons.business, size: 16, color: AppColor.primaryColor),
                  const SizedBox(width: 4),
                  Text(
                    complaint.company!.name,
                    style: const TextStyle(color: AppColor.baseFontColor),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
            // الموقع
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: AppColor.primaryColor),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    complaint.location,
                    style: const TextStyle(color: AppColor.baseFontColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // الوصف
            Text(
              complaint.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            // التاريخ والحالة
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  complaint.createdAt != null
                      ? '${complaint.createdAt!.day}/${complaint.createdAt!.month}/${complaint.createdAt!.year}'
                      : 'غير محدد',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColor.primaryColor,
                  ),
                ),
                if (complaint.status != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: _getStatusColor(complaint.status!),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      complaint.status!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ),
                // زر التعديل - تم التصحيح هنا
                IconButton(
                  onPressed: () => _editComplaint(complaint),
                  icon: Icon(Icons.edit, color: AppColor.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _editComplaint(ComplaintModel complaint) {

    controller.loadComplaintForEditing(complaint);
    

    Get.toNamed('/addComplaint');
    
    print('✏️ فتح الشكوى رقم ${complaint.id} للتعديل');
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'مقبول':
      case 'مكتمل':
        return Colors.green;
      case 'قيد المراجعة':
        return Colors.orange;
      case 'مرفوض':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}