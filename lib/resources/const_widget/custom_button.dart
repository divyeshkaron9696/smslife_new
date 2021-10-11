import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get_served/resources/color_resources.dart';

class CustomButton extends StatefulWidget {
  final String text;
  Color? color,fontcolor,iconcolor;
  double? fontsize,iconsize;
  bool? isloading,buttoncenter;
  FontWeight? fontWeight;
  Alignment? alignment,buttonalignment;
  BorderRadius? borderRadius;
  BoxShadow? boxShadow;
  Gradient? gradient;
  IconData? iconname;
  EdgeInsetsGeometry? padding,margin;
  void Function()? onTap;
  CustomButton(this.text,
      this.color,
      this.isloading,
      {this.margin,
        this.gradient,
        this.iconname,
        this.iconsize,
        this.buttoncenter,
        this.fontcolor,
        this.iconcolor,
        this.alignment,
        this.padding,
        this.onTap,
        this.boxShadow,
        this.fontsize,
        this.fontWeight,
        this.borderRadius});
  @override
  State<StatefulWidget> createState() {
    return _CustomButtonState();
  }
}
class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return widget.buttoncenter==null?widget.boxShadow!=null?Padding(
      padding: widget.margin==null?EdgeInsets.only(left: 20,right: 20):widget.margin!,
      child: InkWell(
        onTap:widget.onTap,
        child: Container(
          alignment: widget.alignment==null?Alignment.center:widget.alignment,
          padding: widget.padding==null?EdgeInsets.only(top: 15,bottom: 15):widget.padding,
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: widget.borderRadius==null?BorderRadius.circular(0):widget.borderRadius,
              boxShadow:[widget.boxShadow!],
              gradient: widget.gradient==null?
              LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [ widget.color!,  widget.color!]):widget.gradient,
          ),
          child: widget.isloading!?Center(child: CircularProgressIndicator(backgroundColor: ColorRes.orange,valueColor:AlwaysStoppedAnimation<Color>(ColorRes.red),),):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.iconname!=null?Icon(widget.iconname,size: widget.iconsize??20,color: widget.iconcolor??Colors.white,):Container(),
              Text(widget.text,style: TextStyle(color: widget.fontcolor==null?Colors.white: widget.fontcolor,fontSize: widget.fontsize==null?18:widget.fontsize,fontWeight: widget.fontWeight==null?FontWeight.w400:widget.fontWeight),),
            ],
          ),
        ),
      ),
    ):
    Padding(
      padding: widget.margin==null?EdgeInsets.only(left: 20,right: 20):widget.margin!,
      child: InkWell(
        onTap:widget.onTap,
        child: Container(
          alignment: widget.alignment==null?Alignment.center:widget.alignment,
          padding: widget.padding==null?EdgeInsets.only(top: 15,bottom: 15):widget.padding,
          decoration: BoxDecoration(
              color: widget.color,
              borderRadius: widget.borderRadius==null?BorderRadius.circular(0):widget.borderRadius,
              gradient: widget.gradient==null?
              LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [ widget.color!,  widget.color!]):widget.gradient,
          ),
          child: widget.isloading!?Center(child: CircularProgressIndicator(backgroundColor: ColorRes.orange,valueColor:AlwaysStoppedAnimation<Color>(ColorRes.red),),):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.iconname!=null?Icon(widget.iconname,size: widget.iconsize??20,color: widget.iconcolor??Colors.white,):Container(),
              Text(widget.text,style: TextStyle(color: widget.fontcolor==null?Colors.white: widget.fontcolor,fontSize: widget.fontsize==null?18:widget.fontsize,fontWeight: widget.fontWeight==null?FontWeight.w400:widget.fontWeight),),
            ],
          ),
        ),
      ),
    ):widget.boxShadow!=null?InkWell(
      onTap: () =>widget.onTap,
      child: Center(
        child: Container(
          padding: widget.padding==null?EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20):widget.padding,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: widget.borderRadius==null?BorderRadius.circular(0):widget.borderRadius,
            boxShadow:[widget.boxShadow!],
            gradient: widget.gradient==null?
            LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [ widget.color!,  widget.color!]):widget.gradient,
          ),
          child: widget.isloading!?Center(child: CircularProgressIndicator(backgroundColor: ColorRes.orange,valueColor:AlwaysStoppedAnimation<Color>(ColorRes.red),),):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.iconname!=null?Icon(widget.iconname,size: widget.iconsize??20,color: widget.iconcolor??Colors.white,):Container(),
              Text(widget.text,style: TextStyle(color: widget.fontcolor==null?Colors.white: widget.fontcolor,fontSize: widget.fontsize==null?18:widget.fontsize,fontWeight: widget.fontWeight==null?FontWeight.w400:widget.fontWeight),),
            ],
          ),
        ),
      ),
    ):
    InkWell(
      onTap:()=> widget.onTap,
      child: Center(
        child: Container(
          padding: widget.padding==null?EdgeInsets.only(top: 15,bottom: 15,left: 20,right: 20):widget.padding,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: widget.borderRadius==null?BorderRadius.circular(0):widget.borderRadius,
            gradient: widget.gradient==null?
            LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [ widget.color!,  widget.color!]):widget.gradient,
          ),
          child: widget.isloading!?Center(child: CircularProgressIndicator(backgroundColor: ColorRes.orange,valueColor:AlwaysStoppedAnimation<Color>(ColorRes.red),),):
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.iconname!=null?Icon(widget.iconname,size: widget.iconsize??20,color: widget.iconcolor??Colors.white,):Container(),
              Text(widget.text,style: TextStyle(color: widget.fontcolor==null?Colors.white: widget.fontcolor,fontSize: widget.fontsize==null?18:widget.fontsize,fontWeight: widget.fontWeight==null?FontWeight.w400:widget.fontWeight),),
            ],
          ),
        ),
      ),
    );
  }
}