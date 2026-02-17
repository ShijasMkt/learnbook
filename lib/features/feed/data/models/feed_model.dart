import 'package:learnbook/features/home/data/models/user_model.dart';

class FeedModel {
  final int id;
  final String description;
  final String image;
  final String video;
  final List<int> likes;
  final List<int> dislikes;
  final List<int> bookmarks;
  final List<int> hide;
  final String createdAt;
  final bool follow;
  final UserModel user;

  FeedModel({
    required this.id,
    required this.description,
    required this.image,
    required this.video,
    required this.likes,
    required this.dislikes,
    required this.bookmarks,
    required this.hide,
    required this.createdAt,
    required this.follow,
    required this.user,
  });

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      likes: List<int>.from(json['likes'] ?? []),
      dislikes: List<int>.from(json['dislikes'] ?? []),
      bookmarks: List<int>.from(json['bookmarks'] ?? []),
      hide: List<int>.from(json['hide'] ?? []),
      createdAt: json['created_at'] ?? '',
      follow: json['follow'] ?? false,
      user: UserModel.fromJson(json['user'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'image': image,
      'video': video,
      'likes': likes,
      'dislikes': dislikes,
      'bookmarks': bookmarks,
      'hide': hide,
      'created_at': createdAt,
      'follow': follow,
      'user': user.toJson(),
    };
  }
}
