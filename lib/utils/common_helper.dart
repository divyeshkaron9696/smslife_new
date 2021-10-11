import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonHelper {
  // Call Url
  static void getWebSiteUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
  static void opencall(String number) async {
    if (await canLaunch('tel:+91$number')) {
      await launch('tel:+91$number');
    } else {
      throw 'Could not launch $number';
    }
  }
  static void openwhatsapp(String number) async {
    var url = "https://wa.me/91$number?text=Hello,\ncan you please provide password my contact number is ";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  // Call Url
  // Validation
  static String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value))
      return "Please Enter Valid Email";
    else
      return '';
  }

  static String? validateMobile(String? value) {
    String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
    RegExp regExp = new RegExp(patttern);
    if (value!.length != 10)
      return 'Please enter Mobile Number must be of 10 digit';
    else if (!regExp.hasMatch(value))
      return 'Please enter valid mobile number';
    else
      return null;
  }
  static String validateUrl(String value) {
    var urlPattern = r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
    RegExp regExp = new RegExp(urlPattern);
    if (!regExp.hasMatch(value))
      return "Please Enter Valid Link";
    else
      return '';
  }
  // Validation
  // Date Format
  static String formattedDate(String value) {
    DateFormat format = DateFormat("dd-MMMM-yyyy");
    return DateFormat('yyyy-MM-dd').format(format.parse(value));
  }
  // Date Format

}