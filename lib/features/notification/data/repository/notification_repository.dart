
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:governments_complaints/core/network/api_end_point.dart';
import '../../../../core/network/api_handler.dart';
import '../../../../core/network/dio_helper.dart';
import '../../../../core/network/exceptions.dart';

class NotificationRepository {
  Future<Either<AppException, Response>> getNoti() async {
    return ApiHandler.request(
          () => DioHelper.postData(url: ApiEndPoints.noti),
    );
  }

}