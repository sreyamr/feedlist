import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:round2/models/feedlist_model.dart';
import 'package:round2/models/result_model.dart';
import '../config/app_controller.dart';
import '../utlis/urls.dart';


class FeedListProvider with ChangeNotifier {
  List<ResultModel> _feedList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ResultModel> get feedList => _feedList;

  Future<void> getFeedList() async {
    final url = Uri.parse(Urls.home); // Ensure the URL is correct
    print(url);
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(url);

      if (response.statusCode == 202) {
        final Map<String, dynamic> data = json.decode(response.body);
        print(data);

        if (data['results'] != null) {
          List<dynamic> results = data['results'];
          _feedList = results.map((json) => ResultModel.fromJson(json)).toList();
          print(_feedList);
        }
        else {
          print('No results found in the response');
        }
      } else {
        print('Fetch failed: ${response.body}');
      }
    } catch (e) {
      print('An error occurred: $e');
    } finally {

      _isLoading = false;
      notifyListeners();
    }
  }
}

