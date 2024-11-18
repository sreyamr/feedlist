import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:round2/models/feedlist_model.dart';
import '../config/app_controller.dart';
import '../utlis/urls.dart';


class AddFeed with ChangeNotifier {
  bool _addSuccess = false;
  String? _errorMessage;
  bool get addSuccess => _addSuccess;
  String? get errorMessage => _errorMessage;

  Future<void> addFeed(FeedListModel feedList) async {
    final url = Uri.parse(Urls.addFeed);
    print(url);
    String? token = await AppController.getToken();
    try {
      var jsonData = feedList.toJson();
      print(jsonData);
      final response = await http.post(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
        body:jsonData,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);
        _addSuccess = true;
      } else {
        print('Add Patient failed: ${response.body}');
        _addSuccess = false;
      }
      notifyListeners();
    } catch (e) {
      print('An error occurred: $e');
      _addSuccess = false;
      notifyListeners();
    }
  }

}


