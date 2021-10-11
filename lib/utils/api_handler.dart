import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'error_handler.dart';

class ApiHandler {

  static Future<dynamic> post (url,{headers, body, encoding}) async {
    try {
      http.Response response = await http.post(Uri.parse(url), headers: headers, body: body, encoding: encoding);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }

  static Future<dynamic> get (String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }
  static Future<dynamic> postImage(url,
      {required Map<String, String> body,licimage,coverimage,logoimage}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('post', Uri.parse(url));
      body.entries.forEach((element) async {
        request..fields[element.key] = element.value;
      });
      if (coverimage != null) {
        request.files
          ..add((await http.MultipartFile.fromPath("cover", coverimage)));
      }
      if (logoimage != null) {
        print("logo");
        request.files
          ..add((await http.MultipartFile.fromPath("logo", logoimage)));
      }
      if (licimage != null) {
        request.files
          ..add((await http.MultipartFile.fromPath("licence", licimage)));
      }
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return json.decode(respStr);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }
  static Future<dynamic> postImage3(url,
      {required Map<String, String> body,image}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('post', Uri.parse(url));
      body.entries.forEach((element) async {
        request..fields[element.key] = element.value;
      });
      if (image != null) {

        request.files
          ..add((await http.MultipartFile.fromPath("image", image)));
      }
      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return json.decode(respStr);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }
  static Future<dynamic> postImage1(url,
      {required Map<String, String> body,image1,image2,image3,image4}) async {
    try {
      http.MultipartRequest request = http.MultipartRequest('post', Uri.parse(url));
      body.entries.forEach((element) async {
        request..fields[element.key] = element.value;
      });
      if (image1 != null) {
        request.files
          ..add((await http.MultipartFile.fromPath("image1", image1)));
      }
      if (image2 != null) {
        request.files
          ..add((await http.MultipartFile.fromPath("image2", image2)));
      }
      if (image3 != null) {
        request.files
          ..add((await http.MultipartFile.fromPath("image3", image3)));
      }
      if (image4 != null) {
        request.files
          ..add((await http.MultipartFile.fromPath("image4", image4)));
      }

      http.StreamedResponse response = await request.send();
      final respStr = await response.stream.bytesToString();
      if (response.statusCode == 200) {
        return json.decode(respStr);
      } else {
        throw ErrorHandler(code: response.statusCode);
      }
    } on FormatException {
      throw ErrorHandler(message: "Bad Response Format");
    } on SocketException {
      throw ErrorHandler(message: "Internet Connection Failure");
    } on HttpException {
      throw ErrorHandler(message: "Connection Problem");
    } on Exception catch (ex) {
      throw ErrorHandler(message: ex.toString().replaceAll("Exception: ", ""));
    }
  }
}