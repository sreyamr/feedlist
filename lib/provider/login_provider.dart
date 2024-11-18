import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../config/app_controller.dart';
import '../models/login_model.dart';
import '../utlis/urls.dart';


class LoginProvider with ChangeNotifier {
  bool _loginSuccess = false;
  String? _errorMessage;

  bool get loginSuccess => _loginSuccess;

  String? get errorMessage => _errorMessage;

  Future<void> loginUser(UserModel usermodel) async {
    final url = Uri.parse(Urls.login);
    print(url);
    try {
      var jsonData = usermodel.toJson();
      print(jsonData);
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: jsonData,
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        String accessToken = data['token']['access'];
        print(accessToken);
        await AppController.saveToken(accessToken);

        _loginSuccess = true;
      } else {
        print('Login failed: ${response.body}');
        _loginSuccess = false;
      }
      notifyListeners();
    } catch (e) {
      print('An error occurred: $e');
      _loginSuccess = false;
      notifyListeners();
    }
  }
}

