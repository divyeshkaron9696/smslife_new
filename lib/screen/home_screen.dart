import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_date_picker_timeline/flutter_date_picker_timeline.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:get_served/model/msglist_model.dart';
import 'package:get_served/provider/msglist_provider.dart';
import 'package:get_served/provider/user_provider.dart';
import 'package:get_served/resources/color_resources.dart';
import 'package:get_served/resources/const_widget/custom_scaffold.dart';
import 'package:get_served/resources/image_resources.dart';
import 'package:get_served/resources/string_resources.dart';
import 'package:get_served/resources/text_style.dart';
import 'package:get_served/screen/login_screen.dart';
import 'package:get_served/screen/video_screen.dart';
import 'package:get_served/screen/video_thumbnail.dart';
import 'package:get_served/utils/connectionStatusSingleton.dart';
import 'package:get_served/utils/internetconnection.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MsgListProvider _msgListProvider;
  late UserProvider _userProvider;
  Future<List<MsgListModel>>? msglistdata;
  late SharedPreferences preferences;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey1 = new GlobalKey<RefreshIndicatorState>();
  DateTime? selectedDate = DateTime.now();
  late String language;
  bool isOffline=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createRewardedAd();
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    connectionStatus.connectionChange.listen(connectionChanged);
    checkconnection();
    _loadpref();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        refresh();
      }
    });
  }
  refresh(){
    selectedDate = DateTime.now();
    String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
    _msgListProvider.refreshlist(date);
    setState(() {});
  }
  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }

  _loadpref() async{
    preferences = await SharedPreferences.getInstance();
    language = preferences.getString("language")??"en_US";
    changeLocale(context, language);
  }
  void checkconnection()async {
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    isOffline = await connectionStatus.check();
    setState(() {
    });
    _msgListProvider.msglistdata!.then((value) => print(value!.length));
  }
  int maxFailedLoadAttempts = 3;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      exit(0);
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        exit(0);
        //_createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    _msgListProvider = Provider.of<MsgListProvider>(context,listen: true);
    _userProvider = Provider.of<UserProvider>(context,listen: true);
    if (isOffline) {
      return InternetConnection.nointernetconnection();
    }else{
      return WillPopScope(
        onWillPop: () => _showRewardedAd(),
        child: CustomScaffold(
            statusbarcolor:ColorRes.transparent,
            appbar: true,
            centerTitle: true,
            appbarBackgroundColor: ColorRes.red,
            appbartitle: "Poultry Rates",
            leading: Padding(
              padding: const EdgeInsets.all(15.0),
              child: InkWell(
                  onTap: (){
                    _onActionSheetPress(context,language);
                  },
                  child: Image.asset(ImageRes.language,color:ColorRes.white)),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                    onTap: () async{
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(translate("text.logout")),
                          content: Text(translate("text.areyousure")),
                          actions: [
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Text(translate("text.no")),
                            ),
                            // ignore: deprecated_member_use
                            FlatButton(
                              onPressed: () async {
                                await _userProvider.userlogout(context: context);
                                Navigator.pushAndRemoveUntil(context, PageTransition(child: LoginScreen(), type: PageTransitionType.fade), (route) => false);
                              },
                              child: Text(translate("text.yes")),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Icon(Ionicons.power_outline,size: 25,)),
              )
            ],
            body: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: ColorRes.white,
                      boxShadow: [
                        BoxShadow(color: ColorRes.greyLight,blurRadius: 5)
                      ]
                  ),
                  child: FlutterDatePickerTimeline(
                    listViewPadding: EdgeInsets.zero,
                    selectedItemMargin: EdgeInsets.zero,
                    itemRadius: 0,
                    itemHeight: 75,
                    selectedItemWidth: 90,
                    unselectedItemWidth: 90,
                    unselectedItemTextStyle: TextStyleRes.datepickerunselectedTextstyle,
                    selectedItemTextStyle: TextStyleRes.datepickerselectedTextstyle,
                    unselectedItemBackgroundColor: ColorRes.white,
                    selectedItemBackgroundColor: ColorRes.orange,
                    startDate: DateTime.now().add(Duration(days: -8)),
                    endDate: DateTime.now(),
                    initialSelectedDate: selectedDate,
                    onSelectedDateChange: (DateTime? dateTime) async{
                      setState(() {
                        selectedDate = dateTime;
                        String date = DateFormat("yyyy-MM-dd").format(dateTime!);
                        _msgListProvider.refreshlist(date);
                        //msglistdata = _msgListProvider.getMsgListdata(date);
                      });
                      // setState(() {
                      // });
                    },
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    key: _refreshIndicatorKey1,
                    color: Colors.black,
                    onRefresh: () async {
                      setState(() {
                        String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                        _msgListProvider.refreshlist(date);
                      });
                      //await _msgListProvider.getMsgListdata("");
                      // setState(() {
                      //
                      // });
                    },
                    child: FutureBuilder<List<MsgListModel>?>(
                      future: _msgListProvider.msglistdata,
                      builder: (context,snapshot) {
                        print(snapshot.error);
                        if (snapshot.connectionState == ConnectionState.waiting)
                        {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: ColorRes.orange,
                              valueColor:AlwaysStoppedAnimation<Color>(ColorRes.red),
                            ),
                          );
                        }
                        else if (!snapshot.hasData) {
                          return Container(
                            height: MediaQuery.of(context).size.height*0.8,
                            child: Center(
                              child: Text(translate("text.noDataAvailable")),
                            ),
                          );
                        }
                        return ListView(
                          // shrinkWrap: true,
                          // physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.only(top: 15),
                          children: snapshot.data!.map((data) =>
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [BoxShadow(color: ColorRes.greyLight,blurRadius: 2,spreadRadius: 2,offset: Offset(2,2))],
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    data.type=="image"?
                                    FullScreenWidget(
                                      backgroundColor: ColorRes.white,
                                      backgroundIsTransparent: false,
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                                          child: Image.network(data.url!,alignment: Alignment.center,
                                            errorBuilder:(BuildContext context, Object exception, StackTrace? stackTrace) {
                                              return Padding(
                                                padding: const EdgeInsets.only(left: 10,top: 10),
                                                child: const Text('Image not available'),
                                              );
                                            },),
                                        ),
                                      ),
                                    ):
                                   data.type=="video"?
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,PageTransition(child: VideoScreen(url: data.url,title: data.message,), type: PageTransitionType.leftToRight));
                                      },
                                      child: VideoDesignScreen(url: data.url!,),
                                    )
                                        :Container(),
                                    // VideoPlayer(VideoPlayerController.network(UrlResources.ImageURL+data.url!)),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10,top: 10),
                                      child: Text(data.message!,style:TextStyleRes.newtest1),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(left: 10,top: 5),
                                    //   child: Text("Google is Redefining mobile",style:TextStyleRes.newtest2),
                                    // ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 10,top: 5,bottom: 10),
                                        child: Text(data.addedDateTime!,style:TextStyleRes.newtest3),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ).toList(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            )
        ),
      );
    }
  }
  void showDemoActionSheet({required BuildContext context, required Widget child}) {
    showCupertinoModalPopup<String>(
        context: context,
        builder: (BuildContext context) => child).then((String? value)
    {
      if(value != null)
        changeLocale(context, value);
    });
  }
  void _onActionSheetPress(BuildContext context,String language) {
   showAdaptiveActionSheet(
        context: context,
        actions: <BottomSheetAction>[
          BottomSheetAction(
            title: Text("English",style: TextStyle(color: language=="en_us"?ColorRes.red:ColorRes.black),),
            onPressed: () async {
              await preferences.setString('language',"en_us");
              setState(() {
                _loadpref();
                String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                print(date);
                _msgListProvider.updateUserLanguage();
                _msgListProvider.refreshlist(date);
              });
              Navigator.pop(context, 'en_US');
            }
          ),
          BottomSheetAction(
          title: Text("ગુજરાતી",style: TextStyle(color: language=="gu"?ColorRes.red:ColorRes.black),),
            onPressed: () async {
              await preferences.setString('language',"gu");
              setState(() {
                _loadpref();
                String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                print(date);
                _msgListProvider.updateUserLanguage();
                _msgListProvider.refreshlist(date);
              });
              Navigator.pop(context, 'gu');
            }
          ),
          BottomSheetAction(
          title: Text("हिंदी",style: TextStyle(color: language=="hi"?ColorRes.red:ColorRes.black),),
            onPressed: () async {
              await preferences.setString('language',"hi");
              setState(() {
                _loadpref();
                String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                print(date);
                _msgListProvider.updateUserLanguage();
                _msgListProvider.refreshlist(date);
              });
              Navigator.pop(context, 'hi');
            }
          ),
          BottomSheetAction(
            title: Text("ಕನ್ನಡ",style: TextStyle(color: language=="kn"?ColorRes.red:ColorRes.black),),
            onPressed: () async {
              await preferences.setString('language',"kn");
              setState(() {
                _loadpref();
                String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                print(date);
                _msgListProvider.updateUserLanguage();
                _msgListProvider.refreshlist(date);
              });
              Navigator.pop(context, 'kn');
            }
          ),
          BottomSheetAction(
            title:Text("मराठी",style: TextStyle(color: language=="mr"?ColorRes.red:ColorRes.black),),
            onPressed: () async {
              await preferences.setString('language',"mr");
              setState(() {
                _loadpref();
                String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                print(date);
                _msgListProvider.updateUserLanguage();
                _msgListProvider.refreshlist(date);
              });
              Navigator.pop(context, 'mr');
            }
          ),
          BottomSheetAction(
            title: Text("தமிழ்",style: TextStyle(color: language=="ta"?ColorRes.red:ColorRes.black),),
            onPressed: () async {
              await preferences.setString('language',"ta");
              setState(() {
                _loadpref();
                String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                print(date);
                _msgListProvider.updateUserLanguage();
                _msgListProvider.refreshlist(date);
              });
              Navigator.pop(context, 'ta');
            }
          ),
          BottomSheetAction(
            title: Text("తెలుగు",style: TextStyle(color: language=="te"?ColorRes.red:ColorRes.black),),
            onPressed: () async {
              await preferences.setString('language',"te");
              setState(() {
                _loadpref();
                String date = DateFormat("yyyy-MM-dd").format(selectedDate!);
                print(date);
                _msgListProvider.updateUserLanguage();
                _msgListProvider.refreshlist(date);
              });
              Navigator.pop(context, 'te');
            }
          ),
        ],
      );
  }
}
