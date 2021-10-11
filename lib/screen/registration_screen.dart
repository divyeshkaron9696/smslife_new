import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:get_served/model/city_model.dart';
import 'package:get_served/provider/log_in_provider.dart';
import 'package:get_served/provider/msglist_provider.dart';
import 'package:get_served/resources/color_resources.dart';
import 'package:get_served/resources/const_widget/custom_button.dart';
import 'package:get_served/resources/const_widget/custom_scaffold.dart';
import 'package:get_served/resources/const_widget/custom_textformfield.dart';
import 'package:get_served/resources/image_resources.dart';
import 'package:get_served/screen/registration_screen.dart';
import 'package:get_served/utils/common_helper.dart';
import 'package:get_served/utils/connectionStatusSingleton.dart';
import 'package:get_served/utils/internetconnection.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  var name = new TextEditingController();
  var mobilenumber = new TextEditingController();
  var password = new TextEditingController();
  var address = new TextEditingController();
  var pincode = new TextEditingController();
  late MsgListProvider _msgListProvider;
  bool passwordvisible=true;
  final formKey = new GlobalKey<FormState>();
  late LogInProvider _logInProvider;
  SharedPreferences? preferences;
  bool isOffline=false;
  final _controller = ScrollController();
  String? cityName,stateName,userType;
  Future<List<CityModel>?>? citylistdata;
  String? cityId,stateId;
  List<String> itemsStateName = [];
  List<String> itemsStateId = [];
  List<String> itemsCityName = [];
  List<String> itemsCityId = [];
  List<String>? _itemList = [
    "Service",
    "Farmer",
    "Trader",
    "Self Employee",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _msgListProvider = Provider.of(context,listen: false);
    _loadpref();
    checkconnection();
    _loadStateData();
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

  _loadStateData() {
    itemsStateName.clear();
    itemsStateId.clear();
    _msgListProvider.statelistdata!.then((value) {
      value!.forEach((element) {
        itemsStateName.add(element.state_name!);
        itemsStateId.add(element.state_id!);
      });
    });
  }
  _loadCityData(StateId){
    itemsCityName.clear();
    itemsCityId.clear();
    citylistdata = _msgListProvider.getCityListdata(StateId);
    citylistdata!.then((value) {
      value!.forEach((element) {
        itemsCityName.add(element.city_name!);
        itemsCityId.add(element.city_id!);
      });
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
  @override
  Widget build(BuildContext context) {
    _logInProvider = Provider.of<LogInProvider>(context, listen: true);
    _msgListProvider = Provider.of<MsgListProvider>(context, listen: true);

    if (isOffline) {
      return InternetConnection.nointernetconnection();
    }else{
      return CustomScaffold(
          isoffline: isOffline,
          statusbarcolor: ColorRes.white,
          body: Container(
            color: ColorRes.white,
            child: Column(
              children: [
                SizedBox(height: 60,),
                Center(child: Image.asset(ImageRes.logo,width: 150,)),
                Expanded(
                  child: SingleChildScrollView(
                    controller: _controller,
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 60),
                            child: CustomTextFormField(translate('text.name'),name,inputtype:TextInputType.text,hinttext:translate('text.name'),borderRadius: BorderRadius.circular(5),
                              validator: (val){
                                if (val!.length<=0)
                                  return translate('text.entername');
                                else
                                  return null;
                              },),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
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
                                validator: (val){
                                  if (val!.length<=0)
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                            child: DropdownButtonFormField(
                                hint: Text(translate('text.selectuser')),
                                items: _itemList!.map((e) => DropdownMenuItem(value: e,child: Text(e))).toList(),
                                onChanged: (val){
                                  setState(() {
                                    userType = val.toString();
                                  });
                                },
                                validator: (val){
                                  if (val==null)
                                    return translate('text.selectuser');
                                  else
                                    return null;
                                },
                                decoration: InputDecoration(
                                filled: true,
                                fillColor:Color(0xfff3f3f4),
                                contentPadding: EdgeInsets.only(left: 10,top: 15,bottom: 15,right: 10),
                                border: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                    borderSide: BorderSide(color: Colors.white24)
                                  //borderSide: const BorderSide(),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                            child: DropdownSearch<String>(
                              mode: Mode.DIALOG,
                              showSearchBox: true,
                              showSelectedItems: true,
                              maxHeight: 400,
                              //items: snapshot.data,
                              items:itemsStateName,
                              compareFn:(item, selectedItem) => true,
                              selectedItem: stateName,
                              showClearButton: true,
                              hint: translate('text.selectstate'),
                              validator: (val){
                                if (val==null)
                                  return translate('text.selectstate');
                                else
                                  return null;
                              },
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor:Color(0xfff3f3f4),
                                contentPadding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
                                border: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                    borderSide: BorderSide(color: Colors.white24)
                                  //borderSide: const BorderSide(),
                                ),
                              ),
                              onChanged: (value) {
                                stateId = "";
                                final index = itemsStateName.indexWhere((element) => element == value);
                                stateId = itemsStateId[index];
                                print(stateId);
                                _loadCityData(stateId);
                                setState(() {});
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                            child: DropdownSearch<String>(
                              mode: Mode.DIALOG,
                              showSearchBox: true,
                              showSelectedItems: true,
                              //items: snapshot.data,
                              maxHeight: 400,
                              items:itemsCityName,
                              compareFn:(item, selectedItem) => true,
                              selectedItem: cityName,
                              showClearButton: true,
                              hint: translate('text.selectcity'),
                              validator: (val){
                                if (val==null)
                                  return translate('text.selectcity');
                                else
                                  return null;
                              },
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor:Color(0xfff3f3f4),
                                contentPadding: EdgeInsets.only(left: 10,top: 5,bottom: 5),
                                border: OutlineInputBorder(
                                  // width: 0.0 produces a thin "hairline" border
                                    borderRadius: BorderRadius.all(Radius.circular(0.0)),
                                    borderSide: BorderSide(color: Colors.white24)
                                  //borderSide: const BorderSide(),
                                ),
                              ),
                              onChanged: (value) {
                                cityId = "";
                                final index = itemsCityName.indexWhere((element) => element == value);
                                cityId = itemsCityId[index];
                                setState(() {});
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
                          //   child: CustomTextFormField(translate('text.address'),address,inputtype:TextInputType.multiline,maxlines: 4,hinttext:translate('text.address'),borderRadius: BorderRadius.circular(5),
                          //     validator: (val){
                          //       if (val!.length<=0)
                          //         return translate('text.enteraddress');
                          //       else
                          //         return null;
                          //     }),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 20),
                            child: CustomTextFormField(translate('text.pincode'),pincode,inputtype:TextInputType.number,hinttext:translate('text.pincode'),borderRadius: BorderRadius.circular(5),
                              maxLength: 6,
                              validator: (val){
                                if (val!.length<=0)
                                  return translate('text.enterpincode');
                                else
                                  return null;
                              }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CustomButton(translate('text.register'), ColorRes.orange,_logInProvider.isLoading,borderRadius: BorderRadius.circular(0),
                    onTap: () async{
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      _controller.animateTo(
                        _controller.position.maxScrollExtent,
                        duration: Duration(milliseconds: 50),
                        curve: Curves.fastOutSlowIn,
                      );
                      if(_logInProvider.isLoading==false){
                        if(formKey.currentState!.validate()){
                          _logInProvider.register(context: context,
                              contactNo: mobilenumber.text,
                              password: password.text,
                              cityId: cityId,
                              name: name.text,
                              pincode: pincode.text,
                              userType: userType);
                        }
                      }
                    }),
                ),
              ],
            ),
          )
      );
    }
  }
}
