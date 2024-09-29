import 'package:flexiscan101/screens/Signin.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('data'),
      ),
      floatingActionButton: ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return Login();
        }));
      }, child: const Icon(Icons.arrow_back)),
    );
  }
}