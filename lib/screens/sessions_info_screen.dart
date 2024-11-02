// screens/sessions_info_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SessionsInfoScreen extends StatelessWidget {
  const SessionsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Container(
                  width: 100, height: 100,
      
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'SessionsInfoScreen'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}