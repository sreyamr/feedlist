class ResultModel {
  int? id; // Keep it as int for internal usage.
  String? description;
  String? image;
  String? video;
  List<int>? likes;
  List<int>? dislikes;
  List<int>? bookmarks;
  List<int>? hide;
  String? createdAt;
  bool? follow;

  ResultModel({
    this.id,
    this.description,
    this.image,
    this.video,
    this.likes,
    this.dislikes,
    this.bookmarks,
    this.hide,
    this.createdAt,
    this.follow,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    return ResultModel(
      id: int.tryParse(json['id'].toString()) ?? 0, // Convert string to int.
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      likes: List<int>.from(json['likes']),
      dislikes: List<int>.from(json['dislikes']),
      bookmarks: List<int>.from(json['bookmarks']),
      hide: List<int>.from(json['hide']),
      createdAt: json['created_at'] ?? '',
      follow: json['follow'] ?? false,
    );
  }
}
