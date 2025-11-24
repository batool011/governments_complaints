import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/features/complaint/presentation/controller/compaint_controller.dart';

import '../../../../core/constant/class/app_color.dart';



class AttachmentOptionsBottomSheet extends StatelessWidget {
  const AttachmentOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ComplaintsController>();
    
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'إضافة مرفق',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            _buildOption(
              icon: Icons.photo_library,
              color: AppColor.primaryColor,
              title: 'المعرض',
              subtitle: 'اختيار صورة من المعرض',
              onTap: () => _handleGalleryTap(controller),
            ),
            _buildOption(
              icon: Icons.camera_alt,
              color: AppColor.green,
              title: 'الكاميرا',
              subtitle: 'التقاط صورة جديدة',
              onTap: () => _handleCameraTap(controller),
            ),
          
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.grey[700],
              ),
              child: const Text('إلغاء'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOption({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }

 void _handleGalleryTap(ComplaintsController controller) {
  Get.back();
  Future.delayed(const Duration(milliseconds: 300), () {
    controller.pickImageFromGallery();
  });
}

void _handleCameraTap(ComplaintsController controller) {
  Get.back();
  Future.delayed(const Duration(milliseconds: 300), () {
    controller.captureImageFromCamera();
  });
}


 
}