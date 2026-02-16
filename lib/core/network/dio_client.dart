import 'package:dio/dio.dart';
import 'package:learnbook/core/network/api_endpoints.dart';
import 'package:learnbook/core/network/dio_interceptor.dart';
import 'package:learnbook/core/storage/secure_storage_service.dart';

class DioClient {
  late final Dio dio;

  DioClient(SecureStorageService storage) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        headers: {
          "Accept": "application/json",
        }
      )
    );

    dio.interceptors.add(DioInterceptor(storage));

    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true
      )
    );
  }
}