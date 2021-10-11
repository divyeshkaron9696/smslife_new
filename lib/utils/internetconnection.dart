import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_served/resources/image_resources.dart';
import 'package:get_served/resources/text_style.dart';

class InternetConnection {
  bool isloading=false;
  static Widget nointernetconnection()
  {
    return Scaffold(
        appBar: null,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  child: Image.asset(ImageRes.logo,width: 300,)
              ),
              SizedBox(height: 40,),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Text("No Internet Connection",style: TextStyleRes.AppbarTextstyle),
              ),
              // SizedBox(height: 20,),
              // Button("Try again",Colors.red,isloading,buttoncenter: true,borderRadius: BorderRadius.circular(30),boxShadow: BoxShadow(color: Colors.grey,blurRadius: 5),)
            ],
          ),
        )
    );
  }
}