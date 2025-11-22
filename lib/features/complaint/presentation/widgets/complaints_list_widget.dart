import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/complaint_model.dart';
import '../controller/compaint_controller.dart';
class ComplaintsListWidget extends GetView<ComplaintController> {
  const ComplaintsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingComplaints.value && controller.complaintsList.isEmpty) {
        return const Center(child: CircularProgressIndicator());
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
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: controller.refreshComplaints,
                child: const Text('تحديث'),
              ),
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: controller.refreshComplaints,
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.complaintsList.length + 1, // +1 لـ loading indicator
          itemBuilder: (context, index) {
            // إذا وصلنا لنهاية القائمة وعندنا المزيد من البيانات
            if (index == controller.complaintsList.length) {
              if (controller.hasMoreComplaints.value) {
                // تحميل المزيد تلقائياً
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
            
            // عرض بيانات الشركة إذا كانت موجودة
            if (complaint.company != null) ...[
              Row(
                children: [
                  const Icon(Icons.business, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    complaint.company!.name,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
            ],
            
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    complaint.location,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            
            Text(
              complaint.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  complaint.createdAt != null 
                      ? '${complaint.createdAt!.day}/${complaint.createdAt!.month}/${complaint.createdAt!.year}'
                      : 'غير محدد',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
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
              ],
            ),
          ],
        ),
      ),
    );
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