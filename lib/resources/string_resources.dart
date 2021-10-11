class StringRes{
  static const String appname = "Get Served";
  static const String login = "Login";
  static const String mobileNumber = "Mobile Number";
  static const String signintocontinue = "Please sign in to continue";
  static const String terms = "By sign in, you agree to our Terms and Conditions";
  static const String homeScreen = "Home Screen";
  static const String reward_ad_id = "ca-app-pub-9024446825921965/4044107742";    // Live
  //static const String reward_ad_id = "ca-app-pub-3940256099942544/5224354917";    // Testing
}
class FontRes {
  static const String ProximaNova = "ProximaNova";
  static const String SFProText = "SFProText";
}

class Patterns {
  static const Pattern name = r'[!@#<>?":_`~;[\]\\|=+)(*&^%\s-]';
  static const Pattern email =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const Pattern phonePattern = r'^(?:[+0]9)?[0-9]{9}$';
  static const Pattern moneyPattern = r'^\d*(\.\d{1,2})?$';
  static const Pattern weightKmPattern = r'^\d*(\.\d{1,3})?$';
}