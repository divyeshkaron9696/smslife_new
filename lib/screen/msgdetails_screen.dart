import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_served/resources/color_resources.dart';
import 'package:get_served/resources/const_widget/custom_scaffold.dart';
import 'package:get_served/resources/image_resources.dart';
import 'package:get_served/resources/text_style.dart';

class MsgDetailScreen extends StatefulWidget {
  const MsgDetailScreen({Key? key}) : super(key: key);

  @override
  _MsgDetailScreenState createState() => _MsgDetailScreenState();
}

class _MsgDetailScreenState extends State<MsgDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        statusbarcolor: ColorRes.transparent,
        statusbarbrightness: Brightness.light,
        body: Column(
          children: [
           Stack(
             children: [
               Image.asset(ImageRes.banner,height:400,width: double.infinity,fit: BoxFit.cover,),
               Padding(
                 padding: const EdgeInsets.only(top: 30,left: 20),
                 child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Image.asset(ImageRes.left_arrow,width:40,color: ColorRes.white,
                     )),
               ),
             ],
           ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10,top: 20),
                            child: Text("Google is Redefining mobile with artificial intelligence",style:TextStyleRes.newdetailstest1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10,top: 10),
                            child: Text("Google is Redefining mobile Google is Redefining mobile Google is Redefining mobile Google is Redefining mobile Google is Redefining mobile Google is Redefining mobile  Google is Redefining mobile Google is Redefining mobile",style:TextStyleRes.newdetailstest2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
}
