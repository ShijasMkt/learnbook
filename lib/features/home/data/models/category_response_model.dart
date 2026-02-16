import 'category_model.dart';

class CategoryResponseModel {
  final List<CategoryModel> categories;
  final bool status;

  CategoryResponseModel({
    required this.categories,
    required this.status,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) {
    return CategoryResponseModel(
      categories: (json['categories'] as List?)
              ?.map((e) => CategoryModel.fromJson(e))
              .toList() ??
          [],
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories.map((e) => e.toJson()).toList(),
      'status': status,
    };
  }
}
