import 'package:flutter/material.dart';

Widget buildButton({
  required width,
  required VoidCallback function,
  required String text,
  required color,
  textColor,
  height,
}) => Container(
  width: width,
  height: height,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(40.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 2,
        blurRadius: 2,
        offset: Offset(2, 2),
      ),
    ],
  ),
  child: TextButton(
    onPressed: function, //Add later
    style: TextButton.styleFrom(
      backgroundColor:color,
    ),
    child: Text(
      text,
      style: TextStyle(
        color:  textColor,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
    ),
  ),
);