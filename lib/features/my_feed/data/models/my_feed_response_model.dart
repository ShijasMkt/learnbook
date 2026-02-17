import 'package:learnbook/features/feed/data/models/feed_model.dart';

class MyFeedResponseModel {
  final int count;
  final List<FeedModel> results;
  final String next;
  final String previous;

  MyFeedResponseModel({
    required this.count,
    required this.previous,
    required this.results,
    required this.next,

  });

  factory MyFeedResponseModel.fromJson(Map<String, dynamic> json) {
    return MyFeedResponseModel(
      results: (json['results'] as List?)
              ?.map((e) => FeedModel.fromJson(e))
              .toList() ??
          [],
      next: json['next'] ?? '',
      previous: json['previous'] ?? '',
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((e) => e.toJson()).toList(),
      'next': next,
      'previous': previous,
      'count': count,
    };
  }
}
