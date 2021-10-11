import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_served/provider/log_in_provider.dart';
import 'package:get_served/provider/msglist_provider.dart';
import 'package:get_served/resources/color_resources.dart';
import 'package:get_served/resources/const_widget/custom_button.dart';
import 'package:get_served/resources/const_widget/custom_scaffold.dart';
import 'package:get_served/resources/const_widget/custom_textformfield.dart';
import 'package:get_served/resources/image_resources.dart';
import 'package:get_served/resources/string_resources.dart';
import 'package:get_served/screen/registration_screen.dart';
import 'package:get_served/utils/common_helper.dart';
import 'package:get_served/utils/connectionStatusSingleton.dart';
import 'package:get_served/utils/internetconnection.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var mobilenumber = new TextEditingController();
  var password = new TextEditingController();
  late MsgListProvider _msgListProvider;
  final formKey = new GlobalKey<FormState>();
  late LogInProvider _logInProvider;
  SharedPreferences? preferences;
  bool isOffline=false,passwordvisible=true;
  int maxFailedLoadAttempts = 3;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _createRewardedAd();
    _loadpref();
    checkconnection();
  }
  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = !hasConnection;
    });
  }
  void checkconnection()async {
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    isOffline = await connectionStatus.check();
    setState(() {
    });
  }
  _loadpref() async{
    ConnectionStatusSingleton connectionStatus = ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    connectionStatus.connectionChange.listen(connectionChanged);
    preferences = await SharedPreferences.getInstance();
    String language = preferences!.getString("language")??"en_US";
    changeLocale(context, language);
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: StringRes.reward_ad_id,
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
  Widget build(BuildContext context) {
    _logInProvider = Provider.of<LogInProvider>(context, listen: true);
    _msgListProvider = Provider.of<MsgListProvider>(context, listen: true);

    if (isOffline) {
      return InternetConnection.nointernetconnection();
    }else{
      return WillPopScope(
        onWillPop: () => _showRewardedAd(),
        child: CustomScaffold(
            isoffline: isOffline,
            statusbarcolor: ColorRes.white,
            body: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Container(
                  color: ColorRes.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60,),
                      Center(child: Image.asset(ImageRes.logo,width: 150,)),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 60),
                        child: CustomTextFormField(translate('text.mobileNumber'),mobilenumber,inputtype:TextInputType.number,hinttext:translate('text.mobileNumber'),borderRadius: BorderRadius.circular(5),
                        maxLength: 10,
                        validator: (value){
                          String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = new RegExp(patttern);
                          if (value!.length != 10)
                            return translate('text.enternumber');
                          else if (!regExp.hasMatch(value))
                            return translate('text.enternumber');
                          else
                            return null;
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                        child: CustomTextFormField(translate('text.password'),password,inputtype:TextInputType.text,hinttext:translate('text.password'),borderRadius: BorderRadius.circular(5),
                            maxLength: 10,
                            validator: (val){
                              if (val==null)
                                return translate('text.enterpassword');
                              else
                                return null;
                            },
                            obscureText:passwordvisible,
                            suffixIcon: passwordvisible?
                            IconButton(icon: Image.asset("assets/images/invisible.png",height: 20,), onPressed: (){
                              setState(() {
                                passwordvisible=false;
                              });

                            }):IconButton(icon: Image.asset("assets/images/view.png",height: 20,), onPressed: (){
                              setState(() {
                                passwordvisible=true;
                              });
                            })),
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: InkWell(
                              onTap: (){
                                CommonHelper.openwhatsapp(_msgListProvider.mobileNumber!);
                              },
                                child: Text(translate('text.forgot'),style: TextStyle(fontSize: 20),)
                            ),
                          )
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: CustomButton(translate("text.login"), ColorRes.orange, _logInProvider.isLoading,borderRadius: BorderRadius.circular(0),
                          onTap: () async{
                            FocusScopeNode currentFocus = FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            if(_logInProvider.isLoading==false)
                            {
                              if(formKey.currentState!.validate())
                              {
                                await _logInProvider.Login(context: context,
                                    contactNo: mobilenumber.text,
                                    password: password.text);
                              }
                            }
                          }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Center(child: Text(translate('text.or'),style: TextStyle(fontSize: 20),))
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40,bottom: 40),
                        child: CustomButton(translate('text.registernow'), ColorRes.orange,false,borderRadius: BorderRadius.circular(0),
                          onTap: () async{
                            Navigator.push(context, PageTransition(child: RegistrationScreen(), type: PageTransitionType.bottomToTop));
                          },),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
      );
    }
  }
}
