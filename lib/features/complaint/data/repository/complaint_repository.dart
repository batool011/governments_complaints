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
    
    print(' Preparing complaint data...');
    print(' Type: ${complaint.type}');
    print(' Company ID: ${complaint.companyId}');
    print(' Location: ${complaint.location}');
    print(' Description: ${complaint.description}');
    print(' Attachments: ${complaint.attachments.length}');
    
    final formData = FormData.fromMap({
      'type': complaint.type,
      'company_id': complaint.companyId,
      'description': complaint.description,
      'location': complaint.location,
    });

    // إضافة المرفقات
    for (final filePath in complaint.attachments) {
      try {
        final file = await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        );
        formData.files.add(MapEntry('attachments[]', file));
        print(' Added attachment: ${filePath.split('/').last}');
      } catch (e) {
        print(' Error adding attachment $filePath: $e');
      }
    }

    print(' Sending complaint to server...');
    final result = await DioHelper.postData(
      url: ApiEndPoints.addComplaint,
      data: formData,
      requiresToken: true,
      isFormData: true,
    );

    return result.fold(
      (l) {
        print(' Complaint submission failed: ${l.message}');
        return Left(l);
      },
      (r) {
        final responseData = r.data;
        print(' Complaint submitted successfully');
        print(' Server Response: $responseData');
        
       
        if (responseData['data'] != null) {
          return Right(ComplaintModel.fromJson(responseData['data']));
        } else {
          print(' No data in response');
          return Left(AppException( 'No data in server response'));
        }
      },
    );
  }

  Future<Either<AppException, DynamicMap>> getUserComplaints({int page = 1}) async {
    print(' Loading complaints page $page...');
    
    final result = await DioHelper.getData(
      url: ApiEndPoints.getAllComplaint,
      query: {'page': page},
      requiresToken: true,
    );

    return result.fold(
      (l) {
        print(' Failed to load complaints: ${l.message}');
        return Left(l);
      },
      (r) {
        final responseData = r.data;
        print(' Complaints loaded successfully');
        print(' Complaints API Response: $responseData');
        
        final List<dynamic> data = responseData['data'] ?? [];
        final meta = responseData['meta'] ?? {};
        
        print(' Found ${data.length} complaints');
        print(' Meta: $meta');
        
        final complaints = data.map((item) {
          try {
            return ComplaintModel.fromJson(item);
          } catch (e) {
            print(' Error parsing complaint: $e');
            print(' Problematic item: $item');
            return ComplaintModel(
              type: 'Unknown',
              companyId: '',
              location: '',
              description: '',
              attachments: [],
            );
          }
        }).toList();
        
        return Right({
          'data': complaints, 
          'meta': meta,
        });
      },
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
        print(' Companies loaded successfully');
        print(' Companies API Response: $responseData');
        
        final List<dynamic> data = responseData['data'] ?? [];
        print(' Found ${data.length} companies');
        
        final companies = data.map((item) {
          try {
            return CompanyModel.fromJson(item);
          } catch (e) {
            print(' Error parsing company: $e');
            print(' Problematic item: $item');
            return CompanyModel(
              id: 0,
              name: 'Unknown Company',
              location: '',
            );
          }
        }).toList();
        
        return Right(companies);
      },
    );
  }


  
Future<Either<AppException, ComplaintModel>> updateComplaint(
    int complaintId, 
    ComplaintModel complaint
) async {
  
  print(' Preparing update data for complaint ID: $complaintId');
  print(' Type: ${complaint.type}');
  print(' Company ID: ${complaint.companyId}');
  print(' Location: ${complaint.location}');
  print(' Description: ${complaint.description}');
  
  final formData = FormData.fromMap({
    'type': complaint.type,
    'company_id': complaint.companyId,
    'description': complaint.description,
    'location': complaint.location,
    '_method': 'PUT', 
  });

  
  for (final filePath in complaint.attachments) {
    try {
      final file = await MultipartFile.fromFile(
        filePath,
        filename: filePath.split('/').last,
      );
      formData.files.add(MapEntry('attachments[]', file));
      print(' Added new attachment: ${filePath.split('/').last}');
    } catch (e) {
      print(' Error adding attachment $filePath: $e');
    }
  }

  print(' Sending update request...');
  final result = await DioHelper.postData(
    url: '${ApiEndPoints.getAllComplaint}/$complaintId', 
    data: formData,
    requiresToken: true,
    isFormData: true,
  );

  return result.fold(
    (l) {
      print(' Complaint update failed: ${l.message}');
      return Left(l);
    },
    (r) {
      final responseData = r.data;
      print(' Complaint updated successfully');
      print(' Server Response: $responseData');
      
      if (responseData['data'] != null) {
        return Right(ComplaintModel.fromJson(responseData['data']));
      } else {
        print(' No data in response');
        return Left(AppException('No data in server response'));
      }
    },
  );
}
}