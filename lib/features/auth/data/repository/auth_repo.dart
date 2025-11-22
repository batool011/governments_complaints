
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:governments_complaints/core/network/api_end_point.dart';
import '../../../../core/network/api_handler.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/exceptions.dart';

class AuthRepository {
  Future<Either<AppException, Response>> register({
    required dynamic data,
  }) async {
    return ApiHandler.request(
      () => DioHelper.postData(url: ApiEndPoints.register, data: data),
    );
  }

  Future<Either<AppException, Response>> login({required dynamic data}) async {
    return ApiHandler.request(
      () => DioHelper.postData(url: ApiEndPoints.login, data: data),

    );
  }

     Future<Either<AppException, Response>> checkOtpCode({
    required dynamic data,
  }) async {
    return ApiHandler.request(
      () => DioHelper.postData(url: ApiEndPoints.verify, data: data,requiresToken: true),
    );
  }
}