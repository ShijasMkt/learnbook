import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../storage/secure_storage_service.dart';
import '../network/dio_client.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final dioProvider = Provider<Dio>((ref) {
  final storage = ref.read(secureStorageProvider);
  return DioClient(storage).dio;
});

final authCheckProvider = FutureProvider<bool>((ref) async {
  final storage = ref.read(secureStorageProvider);
  final token = await storage.getToken();
  return token != null && token.isNotEmpty;
});
