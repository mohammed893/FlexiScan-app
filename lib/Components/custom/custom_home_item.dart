import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

Widget buildHomeItem({
  required backGroundColor,
  required IconData? icon,
  required text,
  required VoidCallback ? onTap,
  fontColor,

}
    ){
  return GestureDetector(
    child: Container(
      height: 100,
      width:90,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Icon(icon,
            color: const Color(0xff233a66),
            size: 45,
          ),
          const SizedBox(height: 8,),
          Text(text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
    onTap: onTap,
  );
}

Widget buildRowHomeItem({
  required String iconText,
  required IconData ? icon,
}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
          text: 'Sessions',
          icon: Icons.accessibility_new,
          onTap: (){}
      ),
      const SizedBox(width: 10,),
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
          text: iconText,
          icon: icon,


          onTap: (){}
      ),     const SizedBox(width: 10,),
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
          text: 'Flexi',
          icon: Icons.chat,
          onTap: (){}
      ),     const SizedBox(width: 10,),
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
          text: 'Ai Scan',
          icon: Icons.search_off,
          onTap: (){}
      ),    ],
  );
}