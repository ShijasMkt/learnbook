import 'package:dio/dio.dart';
import 'package:learnbook/core/storage/secure_storage_service.dart';

class DioInterceptor extends Interceptor {
  final SecureStorageService storage;

  DioInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{
    final token = await storage.getToken();

    if(token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if(err.response?.statusCode == 401){
      storage.clearToken();
    }
    return handler.next(err);
  }
}
