import 'login_model.dart';

class ResultModel {
  int? id;
  String? description;
  String? image;
  String? video;
  List<int>? likes;
  List<int>? dislikes;
  List<int>? bookmarks;
  List<int>? hide;
  DateTime? createdAt;
  bool? follow;
  UserModel? user;

  ResultModel({
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

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: json['id'],
      description: json['description'],
      image: json['image'],
      video: json['video'],
      likes: List<int>.from(json['likes'] ?? []),
      dislikes: List<int>.from(json['dislikes'] ?? []),
      bookmarks: List<int>.from(json['bookmarks'] ?? []),
      hide: List<int>.from(json['hide'] ?? []),
      createdAt: DateTime.parse(json['created_at']),
      follow: json['follow'],
      user: UserModel.fromJson(json['user']),
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
      'created_at': createdAt?.toIso8601String(),
      'follow': follow,
      'user': user?.toJson(),
    };
  }
}
