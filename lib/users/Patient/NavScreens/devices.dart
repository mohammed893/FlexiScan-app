import 'package:flexiscan101/users/Patient/Cubit/cubit.dart';
import 'package:flexiscan101/users/Patient/Cubit/states.dart';
import 'package:flexiscan101/Custom%20Modules/animation_module/custom_components/animation_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Devices extends StatefulWidget {
  const Devices({super.key});
  @override
  _DevicesState createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  double _sliderValue = 0; // State variable for slider value
  final StickManController _stickManController = StickManController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FlexiCubit>(
      create: (context) => FlexiCubit(),
      child: BlocConsumer<FlexiCubit, FlexiStates>(
        listener: (context, state) {
          if (state is BLEDisconnectedState) {
            // FlexiCubit.get(context).changeIndex(0);
            print("POP");
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: SizedBox(
                    height: 300, // Set a fixed height
                    child: StickManScreen(screenSize: 350),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () => _stickManController.setLevel(1),
                  child: Text("Level 1"),
                ),
                ElevatedButton(
                  onPressed: () => _stickManController.setLevel(2),
                  child: Text("Level 2"),
                ),
                ElevatedButton(
                  onPressed: () => _stickManController.setLevel(3),
                  child: Text("Level 3"),
                ),
                ElevatedButton(
                  onPressed: () => _stickManController.setLevel(-1),
                  child: Text("Level 0"),
                ),
                Slider(
                  value: _sliderValue,
                  onChanged: (value) {
                    setState(() {
                      _sliderValue = value;
                      _stickManController.setProgression(value);
                    });
                  },
                  min: 0,
                  max: 1,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
