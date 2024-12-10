
import 'package:flexiscan101/users/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/users/Patient/Cubit/states.dart';
import 'package:flexiscan101/Custom%20Modules/animation_module/custom_components/animation_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Devices extends StatelessWidget {
  const Devices({super.key});
  @override
  Widget build(BuildContext context) {
      double _sliderValue = 0;
    return BlocConsumer<FlexiCubit,FlexiStates>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 300, // Set a fixed height
              child: StickManScreen(screenSize: 350,),
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
      },
    );
  }
}