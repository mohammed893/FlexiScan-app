// Components/custom/custom_home_item.dart
import 'package:flutter/material.dart';

Widget buildHomeItem({
  required Color backGroundColor,
  IconData? icon,
  ImageProvider? image,
  required Color iconColor,
  required String text,
  required VoidCallback? onTap,
  Color fontColor = Colors.white,
}) {
  return GestureDetector(
    child: Container(
      height: 110,
      width: 80,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          if (icon != null) 
            Icon(
              icon,
              color: iconColor,
              size: 40,
            ),
          if (image != null) 
            Image(
              image: image,
              height: 40,
              width: 40,
              fit: BoxFit.contain,
            ),
          const SizedBox(height: 15),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: fontColor,
            ),
          ),
        ],
      ),
    ),
    onTap: onTap,
  );
}


Widget buildRowHomeItem(
  String text1,
  String text2,
  String text3,
  String text4,
  dynamic iconOrImage1,
  dynamic iconOrImage2,
  dynamic iconOrImage3,
  dynamic iconOrImage4,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildHomeItem(
        backGroundColor: const Color(0xffd7a859),
        text: text1,
        icon: iconOrImage1 is IconData ? iconOrImage1 : null,
        image: iconOrImage1 is ImageProvider ? iconOrImage1 : null,
        iconColor: Color.fromARGB(255, 255, 255, 255),
        onTap: () {},
      ),
      const SizedBox(width: 10),
      buildHomeItem(
        backGroundColor: const Color(0xffd7a859),
        text: text2,
        icon: iconOrImage2 is IconData ? iconOrImage2 : null,
        image: iconOrImage2 is ImageProvider ? iconOrImage2 : null,
        iconColor:Color.fromARGB(255, 255, 255, 255),
        onTap: () {},
      ),
      const SizedBox(width: 10),
      buildHomeItem(
        backGroundColor: const Color(0xffd7a859),
        text: text3,
        icon: iconOrImage3 is IconData ? iconOrImage3 : null,
        image: iconOrImage3 is ImageProvider ? iconOrImage3 : null,
        iconColor:Color.fromARGB(255, 255, 255, 255),
        onTap: () {},
      ),
      const SizedBox(width: 10),
      buildHomeItem(
        backGroundColor: const Color(0xffd7a859),
        text: text4,
        icon: iconOrImage4 is IconData ? iconOrImage4 : null,
        image: iconOrImage4 is ImageProvider ? iconOrImage4 : null,
        iconColor:  Color.fromARGB(255, 255, 255, 255),
        onTap: () {},
      ),
    ],
  );
}
