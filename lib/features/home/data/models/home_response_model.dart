import 'package:learnbook/features/home/data/models/category_model.dart';
import 'package:learnbook/features/home/data/models/feed_model.dart';
import 'package:learnbook/features/home/data/models/user_model.dart';

class HomeResponseModel {
  final UserModel? user;
  final List<dynamic> banners;
  final List<CategoryModel> categoryDict;
  final List<FeedModel> results;
  final bool status;
  final bool next;

  HomeResponseModel({
    required this.user,
    required this.banners,
    required this.categoryDict,
    required this.results,
    required this.status,
    required this.next,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeResponseModel(
      user: json['user'] != null ? UserModel.fromJson(json['user']): null,
      banners: json['banners'] ?? [],
      categoryDict: (json['category_dict'] as List?)
              ?.map((e) => CategoryModel.fromJson(e))
              .toList() ??
          [],
      results: (json['results'] as List?)
              ?.map((e) => FeedModel.fromJson(e))
              .toList() ??
          [],
      status: json['status'] ?? false,
      next: json['next'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'banners': banners,
      'category_dict': categoryDict.map((e) => e.toJson()).toList(),
      'results': results.map((e) => e.toJson()).toList(),
      'status': status,
      'next': next,
    };
  }
}
