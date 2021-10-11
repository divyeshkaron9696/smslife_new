import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

ToastFuture styledtoast(context,text,{String? position,color})
{
  return showToast(text,
    context: context,
    backgroundColor: color!=null?color:Colors.grey,
    animation: StyledToastAnimation.slideFromBottom,
    reverseAnimation: StyledToastAnimation.scale,
    position: position!=null?position=="center"?StyledToastPosition.center:position=="top"?StyledToastPosition.top:StyledToastPosition.bottom:StyledToastPosition.bottom,
    animDuration: Duration(seconds: 1),
    duration: Duration(seconds: 4),
    curve: Curves.elasticOut,
    reverseCurve: Curves.linear,
  );
}
