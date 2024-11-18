import 'package:round2/models/result_model.dart';

import 'category_model.dart';

class FeedListModel {
 // List<dynamic>? user;
 // List<dynamic>? banners;
  List<CategoryModel>? categoryDict;
  List<ResultModel>? results;

  FeedListModel({
    //this.user,
   // this.banners,
    this.categoryDict,
    this.results,
  });

  factory FeedListModel.fromJson(Map<String, dynamic> json) {
    return FeedListModel(
     // user: json['user'] ?? [],
     // banners: json['banners'] ?? [],
      categoryDict: (json['category_dict'] is List)
          ? (json['category_dict'] as List)
          .map((item) => CategoryModel.fromJson(item))
          .toList()
          : [],
      results: (json['results'] is List)
          ? (json['results'] as List)
          .map((item) => ResultModel.fromJson(item))
          .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      //'user': user,
    //  'banners': banners,
      'category_dict': categoryDict?.map((item) => item?.toJson()).toList(),
      //'results': results?.map((item) => item?.toJson()).toList(),
    };
  }
}
