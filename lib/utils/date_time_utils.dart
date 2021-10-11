import 'package:intl/intl.dart';

class DateFormats{
  static String dd = "dd";
  static String MM = "MM";
  static String yy = "yy";
  static String yyyy = "yyyy";
  static String EEEE = "EEEE";
  static String HH = "HH";
  static String mm = "mm";
  static String ss = "ss";
  static String hmma_ = "h:mm a";
  static String hmma = "h:mma";
  static String yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS";
  static String yyyyMMddTHHmmssZ = "yyyy-MM-dd'T'HH:mm:ss'Z'"; //2020-05-09T10:52:26Z
  static String yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss";
  static String yyyyMMdd = "yyyy-MM-dd";
  static String MMMMddyyyy = "MMMM dd, yyyy";
  static String yyyyMMddhhmmss = "yyyy-MM-dd HH:mm:ss";
  static String yyyyMMddhhmmss_ = "yyyy_MM_dd_HH_mm_ss";
  static String ddMMyyyy = "dd-MM-yyyy";
  static String ddMMyyyyhhmmssaa = "dd-MM-yyyy hh:mm:ss aa";
  static String hhmmaadMMMyyyy = "hh:mm aa dd MMM yyyy"; //9:00 AM 21 Sep 2019
  static String MMMddyyyyathmma = "MMM dd,yyyy 'at' h:mma";
}

class DateTimeUtils{
  static String currentDateTime(){
    return DateTime.now().toString();
  }

  static currentDate(){
    String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return date;
  }
  static String currentDay(){
    var now = new DateTime.now();
    return now.day.toString();
  }

  static String currentMonth(){
    var now = new DateTime.now();
    return now.month.toString();
  }

  static String currentYear(){
    var now = new DateTime.now();
    return now.year.toString();
  }
//Date Format function
  static String formattedDate(String sourceString,String sourceDateFormat,String sourcegetDateFormat){
    DateFormat format = DateFormat(sourceDateFormat);
    return DateFormat(sourcegetDateFormat).format(format.parse(sourceString));
  }
}