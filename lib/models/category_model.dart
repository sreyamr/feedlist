class CategoryModel {
  int? id;
  String? title;
  String? image;

  CategoryModel({
    this.id,
    this.title,
    this.image,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
    };
  }
}
