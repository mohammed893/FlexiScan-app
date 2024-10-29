import 'package:flexiscan101/On%20Boarding/on_boarding_screen.dart';
import 'package:flexiscan101/Patient/Auth/login.dart';
import 'package:flexiscan101/Patient/Auth/signup.dart';
import 'package:flexiscan101/SharedScreens/home.dart';
import 'package:flutter/material.dart';
import 'SharedScreens/auth_home.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlEXI_SCAN',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

