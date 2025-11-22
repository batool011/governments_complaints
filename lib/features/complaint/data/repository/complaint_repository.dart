import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:governments_complaints/core/constant/class/typedef.dart';
import 'package:governments_complaints/core/network/api_end_point.dart';
import 'package:governments_complaints/core/network/exceptions.dart';
import 'package:governments_complaints/core/network/dio_helper.dart';

import 'package:governments_complaints/features/complaint/data/models/complaint_model.dart';

class ComplaintRepository {
 
  Future<Either<AppException, ComplaintModel>> submitComplaint(
      ComplaintModel complaint) async {
    
    
    final formData = FormData.fromMap({
      'type': complaint.type,
      'company_id': complaint.companyId,
      'description': complaint.description,
      'location': complaint.location,
    });

    for (final filePath in complaint.attachments) {
      final file = await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      );
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
      (r) {
        final responseData = r.data;
        return Right(ComplaintModel.fromJson(responseData['data']));
      },
    );
  }

 

//جلب الشكاوي 

Future<Either<AppException,DynamicMap>> getUserComplaints({int page = 1}) async {
  final result = await DioHelper.getData(
    url: ApiEndPoints.getAllComplaint,
    query: {'page': page}, 
    requiresToken: true,
  );

  return result.fold(
    (l) => Left(l),
    (r) {
      final responseData = r.data;
      final List<dynamic> data = responseData['data'] ?? [];
      final meta = responseData['meta'] ?? {};
      
      final complaints = data.map((item) => ComplaintModel.fromJson(item)).toList();
      
      return Right({
        'complaints': complaints,
        'meta': meta,
      });
    },
  );
}


//جلب الشكاو
  Future<Either<AppException, List<CompanyModel>>> getAllCompanies() async {
    final result = await DioHelper.getData(
      url: ApiEndPoints.getAllCompanies,
      requiresToken: true,
    );

    return result.fold(
      (l) => Left(l),
      (r) {
        final List<dynamic> data = r.data['data'] ?? [];
        return Right(data.map((item) => CompanyModel.fromJson(item)).toList());
      },
    );
  }
}