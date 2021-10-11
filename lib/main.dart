import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:get_served/provider/log_in_provider.dart';
import 'package:get_served/provider/msglist_provider.dart';
import 'package:get_served/provider/user_provider.dart';
import 'package:get_served/resources/string_resources.dart';
import 'package:get_served/resources/color_resources.dart';
import 'package:get_served/screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel? channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'gu', 'hi', 'kn','mr','ta','te']);
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  AwesomeNotifications().initialize(
    // set the icon to null if you want to use the default app icon
      'resource://drawable/logo',
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white
        ),
        NotificationChannel(
            channelKey: 'big_text',
            channelName: 'Big text notifications',
            channelDescription: 'Notifications with a expandable body text',
            vibrationPattern: mediumVibrationPattern,
            importance: NotificationImportance.High),
        NotificationChannel(
            channelKey: 'big_picture',
            channelName: 'Big pictures',
            channelDescription: 'Notifications with big and beautiful images',
            vibrationPattern: mediumVibrationPattern,
            importance: NotificationImportance.High),
      ],
      debug: true
  );
  runApp(LocalizedApp(delegate, MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  void initState() {
    //secureScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;
    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context)=>UserProvider()),
          ChangeNotifierProvider(create: (context)=>LogInProvider()),
          ChangeNotifierProvider(create: (context)=>MsgListProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: StringRes.appname,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            localizationDelegate
          ],
          supportedLocales: localizationDelegate.supportedLocales,
          locale: localizationDelegate.currentLocale,
          theme: ThemeData(
            appBarTheme: AppBarTheme(color: ColorRes.white),
            scaffoldBackgroundColor: ColorRes.white,
            visualDensity:VisualDensity.adaptivePlatformDensity,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}



