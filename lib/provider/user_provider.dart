import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_served/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // isLogin
  Future<bool> isUserLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool('IS_LOGGED_IN') ?? false;
  }

  // isLogin

// isLogin
  Future<Null> userlogout({context}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setBool('IS_LOGGED_IN',false);
    await preferences.setString('USER',"");
  }
  // isLogin

  // Single User Session
  Future<User> getUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    User user = User.fromJson(json.decode(preferences.getString("USER")!));
    return user;
  }
}