import 'package:flexiscan101/animation_module/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexiscan101/animation_module/states.dart'; // Adjust import based on your project structure

class AnimationTestScreen extends StatefulWidget {
  @override
  _AnimationTestScreenState createState() => _AnimationTestScreenState();
}

class _AnimationTestScreenState extends State<AnimationTestScreen>
    with SingleTickerProviderStateMixin {
  late AnimationCubit animationCubit;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    animationCubit = AnimationCubit(this, context); // Initialize here
  }

  @override
  void dispose() {
    animationCubit.close(); // Dispose of the cubit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => animationCubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Animation Test Screen'),
        ),
        body: Center(
          child: BlocBuilder<AnimationCubit, AnimationStates>(
            builder: (context, state) {
              String currentGIF = animationCubit.currentGIF;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Display the current GIF
                  currentGIF.isNotEmpty
                      ? Image.asset(key: ValueKey(currentGIF),
                          currentGIF,
                          width: 200,
                          height: 200,
                        )
                      : Container(),
                  SizedBox(height: 20),

                  // Buttons to trigger state changes
                  ElevatedButton(
                    onPressed: () {
                      animationCubit.changeFromIdle("error" );
                    },
                    child: Text("Trigger Error Animation"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      animationCubit.changeFromIdle("Selected" );
                    },
                    child: Text("Trigger Selected Animation"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      animationCubit.changeFromIdle("Flying" );
                    },
                    child: Text("Trigger Flying Animation"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      animationCubit.changeToIdle(animationCubit.currentState);
                    },
                    child: Text("Return to Idle"),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
