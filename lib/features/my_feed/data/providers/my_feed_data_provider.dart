import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learnbook/core/network/api_endpoints.dart';
import 'package:learnbook/core/providers/core_providers.dart';
import 'package:learnbook/features/my_feed/data/models/my_feed_response_model.dart';

final myFeedDataProvider = FutureProvider<MyFeedResponseModel>((ref) async {
  final dio = ref.read(dioProvider);

  final response = await dio.get(ApiEndpoints.myFeed);

  return MyFeedResponseModel.fromJson(response.data);
});
