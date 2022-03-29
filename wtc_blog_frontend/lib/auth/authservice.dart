import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wtc_blog_frontend/modal/user.dart';

class AuthService with ChangeNotifier {
  User _user;

  User get user => _user;

  AuthService() {
    initialUserData();
  }

  Future initialUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getString("user");

    if (result != null) {
      _user = User.fromJson(jsonDecode(result));
    }

    notifyListeners();
  }

  updateUser(User currentUser) {
    _user = currentUser;
    notifyListeners();
  }
}
