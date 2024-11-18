import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:round2/models/feedlist_model.dart';
import '../config/app_controller.dart';
import '../utlis/urls.dart';


class FeedListProvider with ChangeNotifier {
  List<FeedListModel> _feedList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<FeedListModel> get feedList => _feedList;

  Future<void> getFeedList() async {
    final url = Uri.parse(Urls.home);
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
        _feedList = (data['results'] as List)
            .map((item) => FeedListModel.fromJson(item))
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
