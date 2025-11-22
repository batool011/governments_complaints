import 'dart:io';
import 'package:governments_complaints/core/constant/class/app_color.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'permission_service.dart';

class AttachmentService {
  final ImagePicker _imagePicker = ImagePicker();
  final PermissionService _permissionService = PermissionService();

  // ========== اختيار الصور من المعرض ==========
  Future<File?> pickImageFromGallery() async {
    try {
      print('🎨 محاولة فتح المعرض...');
      
      final hasPermission = await _permissionService.requestGalleryPermission();
      
      if (!hasPermission) {
        print('❌ لا توجد صلاحية للمعرض');
        return null;
      }

      print('📂 فتح المعرض...');
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        print('✅ تم اختيار صورة: ${pickedFile.path}');
        return File(pickedFile.path);
      } else {
        print('ℹ️ المستخدم ألغى عملية الاختيار');
        return null;
      }
    } catch (e) {
      print('❌ خطأ في اختيار الصورة: $e');
      _handleImagePickerError(e);
      return null;
    }
  }

  // ========== التقاط صورة من الكاميرا ==========
  Future<File?> captureImageFromCamera() async {
    try {
      print('📷 محاولة فتح الكاميرا...');
      
      final hasPermission = await _permissionService.requestCameraPermission();
      
      if (!hasPermission) {
        print('❌ لا توجد صلاحية للكاميرا');
        return null;
      }

      print('📸 فتح الكاميرا...');
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        print('✅ تم التقاط صورة: ${pickedFile.path}');
        return File(pickedFile.path);
      } else {
        print('ℹ️ المستخدم ألغى عملية الالتقاط');
        return null;
      }
    } catch (e) {
      print('❌ خطأ في التقاط الصورة: $e');
      _handleImagePickerError(e);
      return null;
    }
  }

  // ========== اختيار ملف ==========
  Future<File?> pickFile() async {
    try {
      print('📁 محاولة اختيار ملف...');
      
      final hasPermission = await _permissionService.requestGalleryPermission();
      
      if (!hasPermission) {
        print('❌ لا توجد صلاحية للملفات');
        return null;
      }

      print('📄 فتح مدير الملفات...');
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        print('✅ تم اختيار ملف: ${pickedFile.path}');
        return File(pickedFile.path);
      } else {
        print('ℹ️ المستخدم ألغى عملية الاختيار');
        return null;
      }
    } catch (e) {
      print('❌ خطأ في اختيار الملف: $e');
      _handleImagePickerError(e);
      return null;
    }
  }

  void _handleImagePickerError(dynamic e) {
    print('❌ خطأ في image_picker: $e');
    
    if (e.toString().contains('PERMISSION_DENIED')) {
      Get.snackbar(
        'خطأ',
        'تم رفض الصلاحية. يرجى منح الصلاحية من إعدادات التطبيق',
        backgroundColor: AppColor.red,
        colorText: AppColor.white,
      );
    } else if (e.toString().contains('Source not available')) {
      Get.snackbar('خطأ', 'المصدر غير متوفر');
    }
  }
}