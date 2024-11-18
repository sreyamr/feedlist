import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../config/app_controller.dart';
import '../models/category_model.dart';
import '../utlis/urls.dart';


class CategoryProvider with ChangeNotifier {
  bool _isLoading = false;
  List<CategoryModel> _categoryModel = [];

  bool get isLoading => _isLoading;
  List<CategoryModel> get category => _categoryModel;

  Future<void> getCategoryList() async {
    final url = Uri.parse(Urls.categoryList);
    print(url);
    String? token = await AppController.getToken();
    print(token);

    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(
        url,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        _categoryModel = (data['patient'] as List)
            .map((item) => CategoryModel.fromJson(item))
            .toList();

      } else {
        print('fetch failed: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
