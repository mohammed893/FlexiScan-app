import 'package:flutter/material.dart';

AppBar  appbar({
  required String title,
  bool showAvatar = true,
  textColor,
  backGroundColor,
  textButtonColor,
  VoidCallback? onPressed,
  VoidCallback? notiOnPressed,
  VoidCallback? menuOnPressed,
  leadingIcon,
  notiIcon,
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
            )),
      IconButton(
        onPressed: notiOnPressed,
        icon: Icon(notiIcon,
          color:Color(0xffd7a859) ,
          size: 40,
        ),
      ),
      if(showAvatar)
        CircleAvatar(
          backgroundColor: Color(0xffd7a859) ,
          radius: 25,
        ),
    ],
    leading: IconButton(
      onPressed: menuOnPressed,
      icon: Icon( leadingIcon,
        color:const Color(0xffd7a859),
        size: 40,
      ),
    ),
  );
}
