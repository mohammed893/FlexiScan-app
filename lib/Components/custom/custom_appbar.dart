import 'package:flutter/material.dart';

AppBar  appbar({
  required String title,
  textColor,
  backGroundColor,
  textButtonColor,
  VoidCallback? onPressed,
}
    ){
  return AppBar(
    title:Text(title,
      style: TextStyle(
        color: textColor,
        fontSize: 25,
      ),
    ) ,
    backgroundColor:backGroundColor ,
    centerTitle: true,
    actions: [
      if(onPressed != null)
      TextButton(
          onPressed: onPressed,
          child: Text('Skip',
          style: TextStyle(
            color: textButtonColor,
            fontSize: 25,
          ),),
      style: TextButton.styleFrom(
        backgroundColor: backGroundColor,
      ))
    ],
  );
}