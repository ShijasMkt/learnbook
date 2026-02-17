import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/network/api_endpoints.dart';
import 'package:learnbook/core/providers/core_providers.dart';
import 'package:learnbook/features/home/data/models/category_response_model.dart';

final categoryListProvider = FutureProvider<CategoryResponseModel>((ref) async {
  final dio = ref.read(dioProvider);

  final response = await dio.get(ApiEndpoints.categoryList);

  return CategoryResponseModel.fromJson(response.data);
});
