import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/compaint_controller.dart';

class AttachedFilesList extends StatelessWidget {
  const AttachedFilesList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ComplaintsController>();

    return Obx(() => Column(
          children: [
            ...controller.attachedFiles.asMap().entries.map((entry) {
              final index = entry.key;
              final file = entry.value['file'] as File;
              final size = entry.value['size'] as int;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: _getFileIcon(file.path),
                  title: Text(
                    file.path.split('/').last,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '${(size / 1024).toStringAsFixed(1)} ك.ب',
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => controller.removeAttachment(index),
                  ),
                ),
              );
            }),

            // زر إضافة مرفقات
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: controller.showAttachmentOptions,
                icon: const Icon(Icons.attach_file),
                label: const Text('إضافة مرفقات'),
              ),
            ),

            if (controller.attachedFiles.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'لا توجد مرفقات مضافة',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
          ],
        ));
  }

  Widget _getFileIcon(String filePath) {
    final extension = filePath.split('.').last.toLowerCase();

    if (['jpg', 'jpeg', 'png', 'gif', 'bmp'].contains(extension)) {
      return const Icon(Icons.image, color: Colors.blue);
    } else if (['pdf'].contains(extension)) {
      return const Icon(Icons.picture_as_pdf, color: Colors.red);
    } else if (['doc', 'docx'].contains(extension)) {
      return const Icon(Icons.description, color: Colors.blue);
    } else {
      return const Icon(Icons.insert_drive_file, color: Colors.grey);
    }
  }
}
