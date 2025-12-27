import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:governments_complaints/core/constant/class/typedef.dart';
import 'package:governments_complaints/core/constant/model/paginated_response.dart';
import 'package:governments_complaints/core/network/api_end_point.dart';
import 'package:governments_complaints/core/network/exceptions.dart';
import 'package:governments_complaints/core/network/dio_helper.dart';
import 'package:governments_complaints/features/complaint/data/models/complaint_model.dart';
import 'package:governments_complaints/features/complaint/data/models/detail_comlaint_model.dart';

import '../../../../core/network/api_handler.dart';

class ComplaintRepository {

//تفاصيل 
  Future<Either<AppException, DetailComplaintModel>> getComplaintDetail({
    required int id,
  })
  async {
    final result = await ApiHandler.request(
          () => DioHelper.getData(
        url: ApiEndPoints.getComplaintDetail(id),
      ),
    );
    print(result);
    return result.fold(
          (failure) => Left(failure),
          (response) => Right(DetailComplaintModel.fromJson(response.data)),
    );
  }
  
  /// جلب الشكاوى 
  Future<Either<AppException, PaginatedResponse<ComplaintModel>>> getComplaints({int page = 1}) async {
    final result = await DioHelper.getData(
      url: ApiEndPoints.getAllComplaint,
      query: {'page': page},
      requiresToken: true,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(
        PaginatedResponse<ComplaintModel>.fromJson(
          r.data,
          (json) => ComplaintModel.fromJson(json),
        ),
      ),
    );
  }

  /// ارسال شكوى جديدة
  Future<Either<AppException, ComplaintModel>> submitComplaint(ComplaintModel complaint) async {
    final formData = FormData.fromMap({
      'type': complaint.type,
      'company_id': complaint.companyId,
      'description': complaint.description,
      'location': complaint.location,
    });

    for (final filePath in complaint.attachments) {
      final file = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
      formData.files.add(MapEntry('attachments[]', file));
    }

    final result = await DioHelper.postData(
      url: ApiEndPoints.addComplaint,
      data: formData,
      requiresToken: true,
      isFormData: true,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(ComplaintModel.fromJson(r.data['data'])),
    );
  }

  /// تحديث شكوى
  Future<Either<AppException, ComplaintModel>> updateComplaint(int complaintId, ComplaintModel complaint) async {
    final formData = FormData.fromMap({
      'type': complaint.type,
      'company_id': complaint.companyId,
      'description': complaint.description,
      'location': complaint.location,
      '_method': 'PUT',
    });

    for (final filePath in complaint.attachments) {
      final file = await MultipartFile.fromFile(filePath, filename: filePath.split('/').last);
      formData.files.add(MapEntry('attachments[]', file));
    }

    final result = await DioHelper.postData(
      url: '${ApiEndPoints.getAllComplaint}/$complaintId',
      data: formData,
      requiresToken: true,
      isFormData: true,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(ComplaintModel.fromJson(r.data['data'])),
    );
  }

  /// حذف شكوى
  Future<Either<AppException, bool>> deleteComplaint(int complaintId) async {
    final result = await DioHelper.deleteData(
      url: '${ApiEndPoints.getAllComplaint}/$complaintId',
      requiresToken: true,
    );

    return result.fold(
      (l) => Left(l),
      (r) => Right(true),
    );
  }


  Future<Either<AppException, List<CompanyModel>>> getAllCompanies() async {
    print(' Loading companies...');
    
    final result = await DioHelper.getData(
      url: ApiEndPoints.getAllCompanies,
      requiresToken: true,
    );

    return result.fold(
      (l) {
        print(' Failed to load companies: ${l.message}');
        return Left(l);
      },
      (r) {
        final responseData = r.data;
      
        print(' Companies API Response: $responseData');
        
        final List<dynamic> data = responseData['data'] ?? [];
     
        
        final companies = data.map((item) {
          
            return CompanyModel.fromJson(item);

        }).toList();
        
        return Right(companies);
      },
    );
  }
}