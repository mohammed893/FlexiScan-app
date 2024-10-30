import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';


void ShowToast({
  required String msg,
  required ToastStates state,
})=>Fluttertoast.showToast(
msg: msg,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  textColor: Colors.white,
);

Color chooseToastStatesColor(ToastStates state){
  Color color;

  switch(state){
    case ToastStates.success:
      color =Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color= Colors.grey;
    default:
      return Colors.white;
  }
  return color;
}





enum ToastStates{ success , error , warning }