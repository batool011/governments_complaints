import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';


class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
   // final languageController = Get.find<LanguageController>();

  //  options.headers['Accept-Language'] = languageController.currentLang.value;
    print('[REQUEST] ${options.method} ${options.uri}');
    print('Headers: ${options.headers}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(dio.Response response, ResponseInterceptorHandler handler) {
    // print('[RESPONSE] ${response.statusCode} ${response.data}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print('[ERROR] ${err.response?.statusCode} ${err.message}');
    super.onError(err, handler);
  }
}
