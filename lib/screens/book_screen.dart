// screens/book_screen.dart

// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flexiscan101/animation_module/custom_components/animation_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _sliderValue = 0;
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          StickManController().setLevel(1);
          StickManController().setProgression(0.5);
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 300, // Set a fixed height
              child: StickManScreen(),
            ),
          ),
          SizedBox(height: 50,),
          ElevatedButton(onPressed: (){
            StickManController().setLevel(1);
          }, child: Text("Level 1")),
          ElevatedButton(onPressed: (){
            StickManController().setLevel(2);

          }, child: Text("Level 2")),
          ElevatedButton(onPressed: (){
            StickManController().setLevel(3);

          }, child: Text("Level 3")
          ),
          ElevatedButton(onPressed: (){
            StickManController().setLevel(-1);

          }, child: Text("Level 0")
          ),
          
          Slider(value: _sliderValue, onChanged: (value) => StickManController().setProgression(value),min: 0,max: 1,)


        ],
      ),
    );
  }
}
