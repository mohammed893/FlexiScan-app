import 'package:flexiscan101/Network/dio_helper.dart';
import 'package:flexiscan101/On%20Boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';




Future<void> initializeApp() async {
  await Future.delayed(const Duration(milliseconds: 200));
}
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

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
    return const MaterialApp(
      title: 'FlEXI_SCAN',
      debugShowCheckedModeBanner: false,
      home:   OnBoardingScreen(),
    );
  }
}

