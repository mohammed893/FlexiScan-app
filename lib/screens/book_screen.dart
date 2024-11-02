// screens/book_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Book Screen'
              ),
            ),
          ],
        ),
      ),
    );
  }
}