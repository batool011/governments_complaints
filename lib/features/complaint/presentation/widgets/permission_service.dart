import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();
  factory PermissionService() => _instance;
  PermissionService._internal();

  // ========== إدارة صلاحيات المعرض ==========
  Future<bool> requestGalleryPermission() async {
    try {
      print('🔍 فحص صلاحية المعرض...');

      PermissionStatus photosStatus = await Permission.photos.status;
      PermissionStatus storageStatus = await Permission.storage.status;

      print('📱 حالة صلاحية الصور: $photosStatus');
      print('📱 حالة صلاحية التخزين: $storageStatus');

      if (photosStatus.isGranted || storageStatus.isGranted) {
        print('✅ الصلاحية ممنوحة بالفعل');
        return true;
      }

      if (photosStatus.isPermanentlyDenied || storageStatus.isPermanentlyDenied) {
        print('❌ الصلاحية مرفوضة بشكل دائم');
        return false;
      }

      print('📝 طلب الصلاحية للمرة الأولى...');
      final newStatus = await Permission.photos.request();
      print('📊 نتيجة طلب الصلاحية: $newStatus');

      return newStatus.isGranted;
    } catch (e) {
      print('❌ خطأ في صلاحية المعرض: $e');
      return false;
    }
  }

  // ========== إدارة صلاحيات الكاميرا ==========
  Future<bool> requestCameraPermission() async {
    try {
      print('🔍 فحص صلاحية الكاميرا...');

      final status = await Permission.camera.status;
      print('📱 حالة صلاحية الكاميرا: $status');

      if (status.isGranted) {
        print('✅ الصلاحية ممنوحة بالفعل');
        return true;
      }

      if (status.isPermanentlyDenied) {
        print('❌ الصلاحية مرفوضة بشكل دائم');
        return false;
      }

      print('📝 طلب الصلاحية للمرة الأولى...');
      final newStatus = await Permission.camera.request();
      print('📊 نتيجة طلب الصلاحية: $newStatus');

      return newStatus.isGranted;
    } catch (e) {
      print('❌ خطأ في صلاحية الكاميرا: $e');
      return false;
    }
  }

  Future<void> openAppSettings() async {
    await openAppSettings();
  }
}