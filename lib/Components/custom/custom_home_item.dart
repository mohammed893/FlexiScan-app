import 'package:flutter/material.dart';

Widget buildHomeItem({
  required backGroundColor,
  required IconData? icon,
  required iconColor,
  required text,
  required VoidCallback ? onTap,
  fontColor,

}
){
  return GestureDetector(
    child: Container(
      height: 110,
      width:90,
      decoration: BoxDecoration(
        color: backGroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10,),
          Icon(icon,
            color: Color(0xff233a66),
            size: 45,
          ),
          const SizedBox(height: 15,),
           Text(text,
            style: TextStyle(
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

Widget buildRowHomeItem(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
        text: 'Sessions',
        icon: Icons.accessibility_new,
        iconColor: Colors.green,
        onTap: (){}
      ),
      const SizedBox(width: 10,),
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
          text: 'Schedule',
          icon: Icons.schedule,
          iconColor: Colors.green,
          onTap: (){}
      ),     const SizedBox(width: 10,),
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
          text: 'Flexi',
          icon: Icons.chat,
          iconColor: Colors.green,
          onTap: (){}
      ),     const SizedBox(width: 10,),
      buildHomeItem(
          backGroundColor:const Color(0xffd7a859),
          text: 'Models',
          icon: Icons.search_off,
          iconColor: Colors.green,
          onTap: (){}
      ),    ],
  );
}