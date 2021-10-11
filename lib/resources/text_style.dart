import 'package:flutter/material.dart';
import 'package:get_served/resources/color_resources.dart';
import 'package:get_served/resources/string_resources.dart';

class TextStyleRes{
  static TextStyle? AppbarTextstyle = TextStyle(
      color: ColorRes.orange,
      fontSize: 25,
      fontFamily: FontRes.ProximaNova,
      fontWeight: FontWeight.bold
  );
  static TextStyle? AppbarTitleTextstyle = TextStyle(
      fontFamily: FontRes.ProximaNova,
      fontWeight: FontWeight.bold,
      color: ColorRes.white,
      fontSize: 24
  );
  static TextStyle? LoginTextStyle = TextStyle(
      fontFamily: FontRes.ProximaNova,
      fontWeight: FontWeight.bold,
      color: ColorRes.blackLight,
      fontSize: 40
  );

  static TextStyle? registeryet = TextStyle(
      fontFamily: FontRes.ProximaNova,
      color: Colors.black,
      fontSize: 20
  );
  static TextStyle? callnow = TextStyle(
      fontFamily: FontRes.ProximaNova,
      color: Colors.blueAccent,
      fontSize: 22
  );
  static TextStyle? datepickerunselectedTextstyle = TextStyle(
      fontFamily: FontRes.ProximaNova,
      fontWeight: FontWeight.bold,
      color: ColorRes.black,
      fontSize: 20
  );
  static TextStyle? datepickerselectedTextstyle = TextStyle(
      fontFamily: FontRes.ProximaNova,
      fontWeight: FontWeight.bold,
      color: ColorRes.white,
      fontSize: 20
  );
  static TextStyle? TermsTextStyle = TextStyle(
      fontFamily: FontRes.ProximaNova,
      color: ColorRes.black,
      fontSize: 18,
  );
  static TextStyle? newtest1 = TextStyle(
      fontFamily: FontRes.ProximaNova,
      fontWeight: FontWeight.bold,
      color: ColorRes.black,
      fontSize: 20
  );
  static TextStyle? newtest2 = TextStyle(
      fontFamily: FontRes.ProximaNova,
      color: ColorRes.greyLight,
      fontSize: 18
  );
  static TextStyle? newtest3 = TextStyle(
      fontFamily: FontRes.ProximaNova,
      color: ColorRes.black,
      fontSize: 16
  );
  static TextStyle? newdetailstest1 = TextStyle(
      fontFamily: FontRes.ProximaNova,
      fontWeight: FontWeight.bold,
      color: ColorRes.black,
      fontSize: 24
  );
  static TextStyle? newdetailstest2 = TextStyle(
      fontFamily: FontRes.ProximaNova,
      color: ColorRes.greyLight,
      fontSize: 20
  );
}