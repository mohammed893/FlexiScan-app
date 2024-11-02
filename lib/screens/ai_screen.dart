// screens/ai_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AIScreen extends StatelessWidget {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:  Expanded(
      child: Container(
        width: 100, height: 100,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Ai screen'
                ),
              ),
            ],
          
        ),
      ),
    ),
  ); 
  }
}