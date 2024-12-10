import 'package:flutter/material.dart';
Widget buildOptionButton(
    {
      required String text,
      required bool isSelected,
      required VoidCallback onTap,

    }) {
  return GestureDetector(
    onTap: onTap,
    child: MouseRegion(
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration:const Duration(milliseconds: 300),
        padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ?Colors.white :const Color(0xffffd691),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color:  isSelected ?Colors.white :const Color(0xffffd691),),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ?const Color(0xff233a66) :Colors.white,
          ),
        ),
      ),
    ),
  );
}
