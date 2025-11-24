import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/complaint_model.dart';
import '../../data/repository/complaint_repository.dart';
import '../widgets/attachment_options_bottom_sheet.dart';
import '../widgets/attachment_service.dart';
import '../widgets/permission_service.dart';

class ComplaintController extends GetxController {
  final ComplaintRepository repository;
  //final PermissionService _permissionService = PermissionService();
  final AttachmentService _attachmentService = AttachmentService();

  ComplaintController(this.repository);

  // ========== متغيرات النموذج ==========
  final complaintTypeController = TextEditingController();
  final governmentEntityController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();
  
  final selectedComplaintType = ''.obs;

  final selectedGovernmentEntity = ''.obs;

  final attachedFiles = <File>[].obs;
  final isLoading = false.obs;

  final currentPage = 1.obs;
final totalPages = 1.obs;
final totalItems = 0.obs;
final hasMoreComplaints = true.obs;
final isLoadMore = false.obs;

  // ========== قائمة الشكاوى ==========
  final complaintsList = <ComplaintModel>[].obs;
  final isLoadingComplaints = false.obs;

  // ========== قائمة الشركات الحكومية ==========
  final companies = <CompanyModel>[].obs;
  final isLoadingCompanies = false.obs;

  // ========== القوائم الثابتة ==========
  final complaintTypes = [
    'Type1',
    'Type2',
    'Type3',
  ];

  // ========== دوال جلب الشركات الحكومية ==========
  List<String> get companyNames {
    return companies.map((company) => company.name).toList();
  }
Future<void> loadCompanies() async {
  try {
    isLoadingCompanies.value = true;
    print(' جلب قائمة الشركات الحكومية...');

    final result = await repository.getAllCompanies();

    result.fold(
      (error) {
        isLoadingCompanies.value = false;
        print(' فشل جلب الشركات: ${error.message}');
        _showErrorSnackbar('فشل في تحميل قائمة الشركات الحكومية: ${error.message}');
      },
      (companiesList) {
        companies.assignAll(companiesList);
        isLoadingCompanies.value = false;
        print('✅ تم جلب ${companiesList.length} شركة حكومية');
        
        // طباعة أسماء الشركات للتأكد
        for (var company in companiesList) {
          print('🏢 ${company.name} - ${company.location}');
        }
      },
    );
  } catch (e) {
    isLoadingCompanies.value = false;
    print('خطأ غير متوقع في جلب الشركات: $e');
    _showErrorSnackbar('حدث خطأ في تحميل قائمة الشركات الحكومية');
  }
}

  // ========== إدارة المرفقات ==========
  Future<void> pickImageFromGallery() async {
    final file = await _attachmentService.pickImageFromGallery();
    if (file != null) {
      attachedFiles.add(file);
      _showSuccessSnackbar('تم إضافة الصورة بنجاح');
    }
  }

  Future<void> captureImageFromCamera() async {
    final file = await _attachmentService.captureImageFromCamera();
    if (file != null) {
      attachedFiles.add(file);
      _showSuccessSnackbar('تم التقاط الصورة بنجاح');
    }
  }

  Future<void> pickFile() async {
    final file = await _attachmentService.pickFile();
    if (file != null) {
      attachedFiles.add(file);
      _showSuccessSnackbar('تم إضافة الملف بنجاح');
    }
  }

  void removeAttachment(int index) {
    attachedFiles.removeAt(index);
    _showSuccessSnackbar('تم إزالة المرفق');
  }

  void showAttachmentOptions() {
    Get.bottomSheet(
    AttachmentOptionsBottomSheet()
    );
  }



  // ========== إدارة الشكاوى ==========
Future<void> loadComplaints({bool loadMore = false}) async {
  try {
    if (loadMore) {
      if (!hasMoreComplaints.value || isLoadMore.value) return;
      isLoadMore.value = true;
    } else {
      isLoadingComplaints.value = true;
      currentPage.value = 1;
      hasMoreComplaints.value = true;
    }

    print('🔄 جلب الشكاوى - الصفحة ${currentPage.value}...');

    final result = await repository.getUserComplaints(page: currentPage.value);

    result.fold(
      (error) {
        isLoadingComplaints.value = false;
        isLoadMore.value = false;
        _showErrorSnackbar(error!.message);
      },
      (response) {
        final List<ComplaintModel> complaints = response['complaints'];
        final meta = response['meta'];
        
        // تحديث بيانات الباجينيشن
        totalPages.value = meta['total_pages'] ?? 1;
        totalItems.value = meta['total'] ?? 0;
        currentPage.value = meta['current_page'] ?? 1;
        hasMoreComplaints.value = currentPage.value < totalPages.value;
        
        if (loadMore) {
          // إضافة الشكاوى الجديدة للقائمة الحالية
          complaintsList.addAll(complaints);
        } else {
          // استبدال القائمة الحالية
          complaintsList.assignAll(complaints);
        }
        
        isLoadingComplaints.value = false;
        isLoadMore.value = false;
        
        if (!loadMore) {
          _showSuccessSnackbar('تم تحميل ${complaints.length} شكوى');
        }
        
        print('✅ تم جلب ${complaints.length} شكوى');
        print('📊 الباجينيشن: الصفحة $currentPage من $totalPages (المجموع: $totalItems)');
      },
    );
  } catch (e) {
    isLoadingComplaints.value = false;
    isLoadMore.value = false;
    print('❌ خطأ غير متوقع: $e');
    _showErrorSnackbar('حدث خطأ غير متوقع: $e');
  }
}
Future<void> loadMoreComplaints() async {
  if (!hasMoreComplaints.value || isLoadMore.value) return;
  
  currentPage.value++;
  await loadComplaints(loadMore: true);
}

// دالة تحديث البيانات
Future<void> refreshComplaints() async {
  currentPage.value = 1;
  await loadComplaints();
}

  // ========== تقديم الشكوى ==========
Future<void> submitComplaint() async {
  if (!_validateForm()) return;

  isLoading.value = true;

  try {
    final filePaths = attachedFiles.map((file) => file.path).toList();
    
    final selectedCompany = companies.firstWhere(
      (company) => company.name == selectedGovernmentEntity.value
    );
    
    final complaint = ComplaintModel(
      type: selectedComplaintType.value, 
      companyId: selectedCompany.id.toString(), 
      location: locationController.text, 
      description: descriptionController.text,
      attachments: filePaths,
      createdAt: DateTime.now(), 
    );

    print('🔄 إرسال الشكوى إلى API...');
    print('📦 بيانات الشكوى: ${complaint.toJson()}');

    final result = await repository.submitComplaint(complaint);

    result.fold(
      (error) {
        isLoading.value = false;
        print(' فشل تقديم الشكوى: ${error.message}');
        _showErrorSnackbar(error.message);
      },
      (successComplaint) {
        isLoading.value = false;
        print(' تم تقديم الشكوى بنجاح: ${successComplaint.type}');
        _showSuccessDialog('تم تقديم الشكوى بنجاح', 'نوع الشكوى: ${successComplaint.type}');
        _resetForm();
        
        // إعادة تحميل قائمة الشكاوى بعد الإضافة
        loadComplaints();
      },
    );
  } catch (e) {
    isLoading.value = false;
    print(' خطأ غير متوقع: $e');
    _showErrorSnackbar('حدث خطأ غير متوقع: $e');
  }
}

  // ========== دوال التحقق ==========

bool _validateForm() {
  if (selectedComplaintType.isEmpty) {
    _showErrorSnackbar('يرجى اختيار نوع الشكوى');
    return false;
  }
  
  if (selectedGovernmentEntity.value == null || selectedGovernmentEntity.value!.isEmpty) {
    _showErrorSnackbar('يرجى اختيار الجهة الحكومية');
    return false;
  }
  

   if (locationController.text.isEmpty) {
    _showErrorSnackbar('يرجى إدخال الموقع');
    return false;
  }
  if (descriptionController.text.isEmpty) {
    _showErrorSnackbar('يرجى إدخال وصف المشكلة');
    return false;
  }
  return true;
}

void _resetForm() {
  complaintTypeController.clear();
  governmentEntityController.clear();
  locationController.clear();
  descriptionController.clear();
  selectedComplaintType.value = '';
    selectedGovernmentEntity.value = ''; 
  attachedFiles.clear();
}

  // ========== دوال المساعدة ==========
  void _showSuccessDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.back();
            },
            child: const Text('حسناً'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      'خطأ',
      message,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 4),
    );
  }

  void _showSuccessSnackbar(String message) {
    Get.snackbar(
      'نجح', 
      message,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    complaintTypeController.dispose();
    governmentEntityController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
    @override
  void onInit() {
    super.onInit();
    
    loadCompanies();
    print('🎯 ComplaintController initialized - loadCompanies called');
  }
}