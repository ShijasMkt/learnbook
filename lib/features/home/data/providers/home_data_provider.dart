import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/network/api_endpoints.dart';
import 'package:learnbook/core/providers/core_providers.dart';
import 'package:learnbook/features/home/data/models/home_response_model.dart';

final homeDataProvider = FutureProvider<HomeResponseModel>((ref) async {
  final dio = ref.read(dioProvider);

  final response = await dio.get(ApiEndpoints.home);

  return HomeResponseModel.fromJson(response.data);
});
