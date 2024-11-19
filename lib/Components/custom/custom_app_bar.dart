// Components/custom/custom_app_bar.dart
import 'package:flutter/material.dart';

AppBar appbar({
  required String title,
  textColor = Colors.black,
  backGroundColor = Colors.white,
  textButtonColor = Colors.black,
  VoidCallback? onPressed,
  VoidCallback? notiOnPressed,
  VoidCallback? menuOnPressed,
  leadingIcon = Icons.menu,
  notiIcon = Icons.notifications_none,
}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: 25,
      ),
    ),
    backgroundColor: backGroundColor,
    centerTitle: true,
    actions: [
      if (onPressed != null)
        TextButton(
          onPressed: onPressed,
          child: Text(
            'Skip',
            style: TextStyle(
              color: textButtonColor,
              fontSize: 25,
            ),
          ),
          style: TextButton.styleFrom(
            backgroundColor: backGroundColor,
          ),
        ),
      IconButton(
        onPressed: notiOnPressed,
        icon: Icon(
          notiIcon,
          color: Color(0xffd7a859),
          size: 35,
        ),
      ),
    ],
    leading: IconButton(
      onPressed: menuOnPressed,
      icon: Icon(
        leadingIcon,
        color: Color(0xffd7a859),
        size: 35,
      ),
    ),
  );
}