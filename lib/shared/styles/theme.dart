// shared/styles/theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'colors.dart';


ThemeData lightTheme= ThemeData(
    scaffoldBackgroundColor: AppColors.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.lightBackground,

      iconTheme: IconThemeData(color: AppColors.lightTextandicon),

      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.lightBackground,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: AppColors.lightTextandicon, fontSize: 30),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: AppColors.,
    //   ),
   // ),
  );

/////////////////////

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.darkBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      iconTheme: IconThemeData(color: AppColors.darkTextandicon),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColors.darkBackground,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(color: AppColors.darkTextandicon, fontSize: 30),
    ),
    // elevatedButtonTheme: ElevatedButtonThemeData(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: AppColors.darkCardBackground,
    //   ),
    // ),
  );
