import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:governments_complaints/core/network/token_storage.dart';
import 'api_end_point.dart';
import 'exceptions.dart';
import 'api_interceptor.dart';

class DioHelper {
  static final Dio _dio =
      Dio(
          BaseOptions(
            baseUrl: ApiEndPoints.baseUrl,
            connectTimeout: const Duration(seconds: 60),
            receiveTimeout: const Duration(seconds: 60),
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'multipart/form-data',
            },
          ),
        )
        ..interceptors.addAll([
          ApiInterceptor(),
          LogInterceptor(
            request: true,
            requestHeader: true,
            requestBody: true,
            responseHeader: true,
            responseBody: true,
            error: true,
          ),
        ]);

  static Future<void> _setHeaders({
    bool requiresToken = false,
    bool? withJsonContent,
  }) async {

    if (requiresToken) {
      final token = await TokenStorage.getToken();
  //   final token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vMjVjZGMwMDkzNWQzLm5ncm9rLWZyZWUuYXBwL2FwaS9hdXRoL2xvZ2luIiwiaWF0IjoxNzY3MDAyMTMyLCJleHAiOjE3NjcwMDU3MzIsIm5iZiI6MTc2NzAwMjEzMiwianRpIjoiN3VzYmF5RVdNMm0wdTI5TCIsInN1YiI6IjQxIiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.yG8AaY8rYlH6Dlr_LMPelA8ohB2RcwOko7i4bg616jc";
      if (token != null && token.isNotEmpty) {
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
      }
    print("withJsonContent");
    print(withJsonContent);
    if (withJsonContent == true) {
      print("withJsonContent headers");
      _dio.options.headers['Content-Type'] = 'application/json';
    }
  }

  ///Generic method for handling both success and errors with Either
  static Future<Either<AppException, Response>> _safeRequest(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(response);
      } else {
        return Left(
          AppException(
            response.data['message'] ??
                'Unexpected status code: ${response.statusCode}',
            statusCode: response.statusCode,
          ),
        );
      }
    } on DioError catch (e) {
      return Left(AppException.fromDioError(e));
    } catch (e) {
      return Left(AppException(e.toString()));
    }
  }

  static Future<Either<AppException, Response>> getData({
    required String url,
    Map<String, dynamic>? query,
    bool requiresToken = true,
  }) async {
    await _setHeaders(requiresToken: requiresToken);
    return _safeRequest(() => _dio.get(url, queryParameters: query));
  }

  static Future<Either<AppException, Response>> postData({
    required String url,
    dynamic data,
    bool requiresToken = false,
     bool isFormData = false,
  }) async {
    await _setHeaders(requiresToken: requiresToken,
         withJsonContent: !isFormData,);
    return _safeRequest(
      () => _dio.post(
        url,
        data: data,
        // options: data is FormData
        //     ? Options(headers: {'Content-Type': 'multipart/form-data'})
        //     : null,
      ),
    );
  }

  static Future<Either<AppException, Response>> putData({
    required String url,
  dynamic data,
    bool requiresToken = false,
       bool isFormData = false,

  }) async {
    await _setHeaders(requiresToken: requiresToken, withJsonContent: !isFormData);
    return _safeRequest(() => _dio.put(url, data: data));
  }

  static Future<Either<AppException, Response>> deleteData({
    required String url,
    Map<String, dynamic>? data,
    bool requiresToken = false,
  }) async {
    await _setHeaders(requiresToken: requiresToken, withJsonContent: true);
    return _safeRequest(() => _dio.delete(url, data: data));
  }

  static Future<Either<AppException, Response>> patchData({
    required String url,
    dynamic data,
    bool requiresToken = false,
  }) async {
    await _setHeaders(requiresToken: requiresToken, withJsonContent: true);
    return _safeRequest(() => _dio.patch(url, data: data));
  }
}
