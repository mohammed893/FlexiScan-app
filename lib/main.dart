import 'package:flexiscan101/Network/dio_helper.dart';
import 'package:flexiscan101/On%20Boarding/on_boarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



Future<void> initializeApp() async {
  await Future.delayed(const Duration(milliseconds: 200));
}
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  ServicesBinding.instance.defaultBinaryMessenger.setMessageHandler('flutter/lifecycle', (ByteData? message) async {
    print("Received a message on flutter/lifecycle channel: $message");
  });

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
      home: OnBoardingScreen(),
    );
  }
}

