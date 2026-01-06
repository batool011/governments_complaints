import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/core/constant/class/app_color.dart';

import 'package:collection/collection.dart';
import 'package:governments_complaints/features/home/presentation/controller/home_controller.dart'; // لـ firstWhereOrNull

class BuildStatsSection extends GetView<HomeStatsController> {
  BuildStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      // استخراج القيم حسب status
      int openCount =
          controller.status.firstWhereOrNull((e) => e.status == 1)?.count ?? 0;
      int resolvedCount =
          controller.status.firstWhereOrNull((e) => e.status == 2)?.count ?? 0;
      int reviewingCount =
          controller.status.firstWhereOrNull((e) => e.status == 3)?.count ?? 0;
      int totalCount = controller.status.fold(0, (sum, e) => sum + e.count);

      return Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'نظرة عامة',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'شكاوى مفتوحة',
                    count: openCount.toString(),
                    color: Colors.orange,
                    icon: Icons.pending_actions,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: 'تم حلها',
                    count: resolvedCount.toString(),
                    color: Colors.green,
                    icon: Icons.check_circle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: 'قيد المراجعة',
                    count: reviewingCount.toString(),
                    color: Colors.blue,
                    icon: Icons.schedule,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    title: 'إجمالي الشكاوى',
                    count: totalCount.toString(),
                    color: AppColor.primaryColor,
                    icon: Icons.assignment,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatCard({
    required String title,
    required String count,
    required Color color,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              Text(
                count,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
