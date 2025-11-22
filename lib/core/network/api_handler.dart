import 'package:dartz/dartz.dart';
import 'exceptions.dart';

class ApiHandler {
  static Future<Either<AppException, T>> request<T>(
    Future<Either<AppException, T>> Function() apiCall,
  ) async {
    // check connectivity
    // if no internet:
    // return Left(AppException("No Internet Connection", 0));

    try {
      final result = await apiCall();
      return result; // Already Either
    } catch (e) {
      return Left(AppException(e.toString(), statusCode: -1));
    }
  }
}
