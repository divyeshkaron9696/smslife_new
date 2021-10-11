import 'dart:convert';
import 'package:device_info/device_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_served/model/city_model.dart';
import 'package:get_served/model/state_model.dart';
import 'package:get_served/resources/const_widget/stylist_toast.dart';
import 'package:get_served/resources/url_resources.dart';
import 'package:get_served/screen/home_screen.dart';
import 'package:get_served/utils/api_handler.dart';
import 'package:get_served/utils/error_handler.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

// Login
  Future<Null> Login({
    context,contactNo,password
  }) async {
    isLoading = true;
    FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    final token = await _firebaseMessaging.getToken();
    print(token);
    String deviceid = await _getId(context);
    print(deviceid);
    try {
      await ApiHandler.post(UrlResources.LOGIN, body: {
        "contactNo":contactNo,
        "password":password,
        "firebaseToken":token,
        "deviceId":deviceid,
      }).then((dynamic value) async {
        isLoading = false;
        print(value);
        if(value["status"] == "true") {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          await preferences.setBool("IS_LOGGED_IN", true);
          await preferences.setString("USER", json.encode(value["data"]));
          styledtoast(context,value["message"]);
          Navigator.pushAndRemoveUntil(context,PageTransition(child: HomeScreen(), type: PageTransitionType.fade),(Route<dynamic> route) => false);
        }else if(value["status"] == "already"){
          styledtoast(context,value["message"]);
        }else{
          styledtoast(context,value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      isLoading = false;
      styledtoast(context,ex.getMessage());
    }
  }
// Login
  // Login
  Future<Null> register({
    context,name,contactNo,password,cityId,pincode,userType
  }) async {
    isLoading = true;
    try {
      await ApiHandler.post(UrlResources.REGISTER, body: {
        "name":name,
        "contactNo":contactNo,
        "password":password,
        "cityId":cityId,
        "pincode":pincode,
        "userType":userType
      }).then((dynamic value) async {
        isLoading = false;
        print(value);
        if(value["status"] == "true") {
          styledtoast(context,value["message"]);
          Navigator.pop(context);
        } else {
          styledtoast(context,value["message"]);
        }
      });
    } on ErrorHandler catch (ex) {
      isLoading = false;
    }
  }
// Login

//Device information
  _getId(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
//Device information
}