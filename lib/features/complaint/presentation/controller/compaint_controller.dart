import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:governments_complaints/features/complaint/data/models/detail_comlaint_model.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/models/complaint_model.dart';
import '../../data/repository/complaint_repository.dart';
import '../widgets/attachment_options_bottom_sheet.dart';

class ComplaintsController extends GetxController {
  final ComplaintRepository repository;


  ComplaintsController(this.repository);

  // متغيرات النموذج
  final complaintTypeController = TextEditingController();
  final governmentEntityController = TextEditingController();
  final locationController = TextEditingController();
  final descriptionController = TextEditingController();

  final selectedComplaintType = ''.obs;
  final selectedGovernmentEntity = ''.obs;
  bool _mounted = true;
  final attachedFiles = <Map<String, dynamic>>[].obs;

  final isLoading = false.obs;
  final isEditing = false.obs;
final editingComplaintId = 0.obs;

  // Pagination
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final totalItems = 0.obs;
  final hasMoreComplaints = true.obs;
  final isLoadMore = false.obs;

  // قائمة الشكاوى
  final complaintsList = <ComplaintModel>[].obs;
  final isLoadingComplaints = false.obs;

  // قائمة الشركات الحكومية
  final companies = <CompanyModel>[].obs;
  final isLoadingCompanies = false.obs;

  // القوائم الثابتة
  final complaintTypes = [
    'Type1',
    'Type2',
    'Type3',
  ];
  /////
  //RxList<dynamic> networkImages = <dynamic>[].obs;
  //final RxList<File> selectedImages = <File>[].obs;
 // final ImagePicker _picker = ImagePicker();
  var complaintsDetail = Rxn<ComplaintData>();
  var errorMessage = ''.obs;

  List<String> get companyNames {
    return companies.map((company) => company.name).toList();
  }
  ///////////
  // networkImages.assignAll(details.media!.images!);
  // if (details.media!.images3d!.isNotEmpty) {
  // threeDFileUrl.value = details.media!.images3d![0];
  // }
  Future<void> getComplainsDetail(int id) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await repository.getComplaintDetail(id: id);

    result.fold(
          (failure) {
        errorMessage.value = failure.message;
        Get.snackbar('خطأ', failure.message);
      },
          (response) {
           //complaintsDetail.value = response.data;
        print('bookingDetails.value!.id');
        print(complaintsDetail.value!.id);
      },
    );

    isLoading.value = false;
  }
  String? dd(String selectedStatu) {
    switch (selectedStatu) {
      case 1:
        return 'انتظار';
      case 2:
        return 'قيد المعالجة';
      case 3:
        return 'مكتمل';

    }
  }
  /// Pick images
  // Future<void> pickImages() async {
  // final pickedFiles = await _picker.pickMultiImage();
  // if (pickedFiles != null) {
  // for (var file in pickedFiles) {
  // final imageFile = File(file.path);
  // final fileSize = await imageFile.length();
  // final fileSizeInMB = fileSize / (1024 * 1024);
  // // if (fileSizeInMB <= 2) {
  // // selectedImages.add(imageFile);
  // // } else {
  // // Get.snackbar(
  // // AppString.fileTooLarge.tr,
  // // AppString.imageMustBeLessThan2MB.tr,
  // // backgroundColor: AppColors.red.withAlpha(40),
  // // );
  // // }
  // }
  // }
  // }

  /// Delete an image
  // void removeImage(File image) {
  // selectedImages.remove(image);
  // }
  // دوال جلب الشركات الحكومية
  Future<void> loadCompanies() async {
    try {
      isLoadingCompanies.value = true;
      final result = await repository.getAllCompanies();

      result.fold(
        (error) {
          isLoadingCompanies.value = false;
          print('فشل تحميل الشركات الحكومية: ${error.message}');
        },
        (companiesList) {
          companies.assignAll(companiesList);
          isLoadingCompanies.value = false;
        },
      );
    } catch (e) {
      isLoadingCompanies.value = false;
      print('حدث خطأ أثناء تحميل الشركات الحكومية: $e');
    }
  }

  //المرفقات
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (image != null && _mounted) {
        final file = File(image.path);
        final size = await file.length();
        
        if (size > 10 * 1024 * 1024) {
          print('حجم الصورة كبير جداً');
          return;
        }
        
        attachedFiles.add({'file': file, 'size': size});
        update(); 
      }
    } catch (e) {
    }
  }

  Future<void> captureImageFromCamera() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );

      if (image != null) {
        final file = File(image.path);
        attachedFiles.add({'file': file, 'size': await file.length()});
        update();
      }
    } catch (e) {
    }
  }

  void removeAttachment(int index) {
    attachedFiles.removeAt(index);
  
    update(); 
  }

  void showAttachmentOptions() {
    try {
      Get.bottomSheet(
        Container(
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
                // خيار المعرض
                ListTile(
                  leading: const Icon(Icons.photo_library, color: Colors.blue),
                  title: const Text('المعرض'),
                  subtitle: const Text('اختيار صورة من المعرض'),
                  onTap: () {
                    Get.back();
                    
                    pickImageFromGallery();
                  },
                ),
                // خيار الكاميرا
                ListTile(
                  leading: const Icon(Icons.camera_alt, color: Colors.green),
                  title: const Text('الكاميرا'),
                  subtitle: const Text('التقاط صورة جديدة'),
                  onTap: () {
                    Get.back();
                    
                    captureImageFromCamera();
                  },
                ),
                const SizedBox(height: 15),
                // زر الإلغاء
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.grey[700],
                    ),
                    child: const Text('إلغاء'),
                  ),
                ),
              ],
            ),
          ),
        ),
        isScrollControlled: true,
        enableDrag: true,
      );
    } catch (e) {
      _showDirectOptions();
    }
  }


  void _showDirectOptions() {
    
    pickImageFromGallery();
  }

//التعديييييل

void loadComplaintForEditing(ComplaintModel complaint) {
  isEditing.value = true;
  editingComplaintId.value = complaint.id ?? 0;
  
  selectedComplaintType.value = complaint.type;
  selectedGovernmentEntity.value = complaint.company?.name ?? '';
  locationController.text = complaint.location;
  descriptionController.text = complaint.description;
  

  attachedFiles.clear();
  
  print('📝 تحميل الشكوى رقم ${complaint.id} للتعديل');
}

//  إلغاء التعديل
void cancelEditing() {
  isEditing.value = false;
  editingComplaintId.value = 0;
  _resetForm();
}

// تحديث الشكوى
Future<void> updateComplaint() async {
  if (!_validateForm()) return;

  isLoading.value = true;

  try {
    final filePaths = attachedFiles.map((e) => (e['file'] as File).path).toList();
    
    if (selectedGovernmentEntity.value.isEmpty) {
      print(' يرجى اختيار الجهة الحكومية');
      isLoading.value = false;
      return;
    }

    final selectedCompany = companies.firstWhere(
      (company) => company.name == selectedGovernmentEntity.value,
    );

    final complaint = ComplaintModel(
      id: editingComplaintId.value,
      type: selectedComplaintType.value,
      companyId: selectedCompany.id,
      location: locationController.text,
      description: descriptionController.text,
      attachments: filePaths,
      createdAt: DateTime.now(),
    );

    final result = await repository.updateComplaint(editingComplaintId.value, complaint);

    result.fold(
      (error) {
        isLoading.value = false;
        Get.snackbar(
          'خطأ',
          'فشل في تحديث الشكوى: ${error.message}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      },
      (updatedComplaint) {
        isLoading.value = false;
        isEditing.value = false;
        editingComplaintId.value = 0;
        
        print(' تم تحديث الشكوى بنجاح: ${updatedComplaint.id}');
        Get.snackbar(
          'نجاح',
          'تم تحديث الشكوى بنجاح',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        _resetForm();
        loadComplaints(); 
        Get.back();  
      },
    );
  } catch (e) {
    isLoading.value = false;
    Get.snackbar(
      'خطأ',
      'حدث خطأ أثناء تحديث الشكوى',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}











  // إدارة الشكاوى
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

     final result = await repository.getComplaints(page: currentPage.value);

result.fold(
  (error) {
    isLoadingComplaints.value = false;
    isLoadMore.value = false;
  },
  (response) {
    totalPages.value = response.meta.totalPages;
    totalItems.value = response.meta.total;
    currentPage.value = response.meta.currentPage;
    hasMoreComplaints.value = currentPage.value < totalPages.value;

    if (loadMore) {
      complaintsList.addAll(response.items);
    } else {
      complaintsList.assignAll(response.items);
    }

    isLoadingComplaints.value = false;
    isLoadMore.value = false;
  },
);

    } catch (e) {
      isLoadingComplaints.value = false;
      isLoadMore.value = false;
      print('خطأ في تحميل الشكاوى: $e');
    }
  }

  Future<void> loadMoreComplaints() async {
    if (!hasMoreComplaints.value || isLoadMore.value) return;
    currentPage.value++;
    await loadComplaints(loadMore: true);
  }

  Future<void> refreshComplaints() async {
    currentPage.value = 1;
    await loadComplaints();
  }

  // تقديم الشكوى
  Future<void> submitComplaint() async {
    if (!_validateForm()) return;

    isLoading.value = true;
    print('بدء تقديم الشكوى...');

    try {
      final filePaths = attachedFiles.map((e) => (e['file'] as File).path).toList();
      
      if (selectedGovernmentEntity.value.isEmpty) {
        print('يرجى اختيار الجهة الحكومية');
        isLoading.value = false;
        return;
      }

      final selectedCompany = companies.firstWhere(
        (company) => company.name == selectedGovernmentEntity.value,
      );

      final complaint = ComplaintModel(
        type: selectedComplaintType.value,
        companyId: selectedCompany.id,
        location: locationController.text,
        description: descriptionController.text,
        attachments: filePaths,
        createdAt: DateTime.now(),
      );

      final result = await repository.submitComplaint(complaint);

      result.fold(
        (error) {
          isLoading.value = false;
          print('فشل تقديم الشكوى: ${error.message}');
        },
        (successComplaint) {
          isLoading.value = false;
          print('تم تقديم الشكوى بنجاح: ${successComplaint.id}');
          _resetForm();
          loadComplaints();
        },
      );
    } catch (e) {
      isLoading.value = false;
      print('خطأ في تقديم الشكوى: $e');
    }
  }

  // دوال التحقق
  bool _validateForm() {
    if (selectedComplaintType.isEmpty) {
      print('يرجى اختيار نوع الشكوى');
      return false;
    }
    if (selectedGovernmentEntity.value.isEmpty) {
      print('يرجى اختيار الجهة الحكومية');
      return false;
    }
    if (locationController.text.isEmpty) {
      print('يرجى إدخال الموقع');
      return false;
    }
    if (descriptionController.text.isEmpty) {
      print('يرجى إدخال وصف المشكلة');
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
    update(); // ⭐ تحديث الواجهة
  }

  void clearTempFiles() {
    for (var attachment in attachedFiles) {
      try {
        final file = attachment['file'] as File;
        if (file.existsSync()) {
          file.deleteSync();
        }
      } catch (e) {
        print('خطأ في حذف الملف المؤقت: $e');
      }
    }
    attachedFiles.clear();
  }

  @override
  void onClose() {
    _mounted = false;
    complaintTypeController.dispose();
    governmentEntityController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    clearTempFiles();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
    loadComplaints();
    loadCompanies();

  }

  @override
  void onInit() {
    super.onInit();
    _mounted = true;
  }
}