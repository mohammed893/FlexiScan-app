import 'package:flexiscan101/animation_module/cubit.dart';
import 'package:flexiscan101/animation_module/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
import 'package:tuple/tuple.dart';

class AIScreen extends StatefulWidget {
  AIScreen({super.key});

  @override
  State<AIScreen> createState() => _AIScreenState();
}

class _AIScreenState extends State<AIScreen> with TickerProviderStateMixin {
  late AnimationCubit animationCubit;
  

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize if not already initialized to avoid redundant calls
    animationCubit = AnimationCubit(this, context); // Initialize without `this` and context
    animationCubit.loadRiveFile(); // Moved here to ensure it runs after initialization
  }

  @override
  void dispose() {
    animationCubit.dispose(); // Use 'close()' for Cubit instead of 'dispose()'
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rive Animation Controls')),
      body: MultiBlocProvider(
        providers: [BlocProvider(create: (context) => animationCubit)],
        child: BlocBuilder<AnimationCubit, AnimationStates>(
          builder: (context, state) => Center(
            child: animationCubit.riveArtBoard == null
                ? const CircularProgressIndicator()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Rive(
                          artboard: animationCubit.riveArtBoard!,
                          fit: BoxFit.contain,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              if(animationCubit.animaState != "Idle"){
                                  animationCubit.toggleInput(animationCubit.animaStates[animationCubit.animaState]);
                                  animationCubit.animaState = "Idle";
                              }
                              animationCubit.toggleInput(animationCubit.animaStates["Fly"]);
                              animationCubit.animaState = "Fly";
                            },
                            child: const Text('Fly'),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            onPressed: () {
                              if(animationCubit.animaState != "Idle"){
                                  animationCubit.toggleInput(animationCubit.animaStates[animationCubit.animaState]);
                                  animationCubit.animaState = "Idle";
                              }
                              animationCubit.toggleInput(animationCubit.animaStates["Error"]);
                              animationCubit.animaState = "Error";;
                            },
                            child: const Text('Error'),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            onPressed: () {
                              if(animationCubit.animaState != "Idle"){
                                  animationCubit.toggleInput(animationCubit.animaStates[animationCubit.animaState]);
                                  animationCubit.animaState = "Idle";
                              }
                              animationCubit.toggleInput(animationCubit.animaStates["Selected"]);
                              animationCubit.animaState = "Selected";
                            },
                            child: const Text('Down'),
                          ),
                          const SizedBox(width: 10),
                          FloatingActionButton(
                            onPressed: () {
                              if (animationCubit.animaState != "Idle"){
                                animationCubit.toggleInput(animationCubit.animaStates[animationCubit.animaState]);
                                animationCubit.animaState = "Idle";
                              }
                            },
                            child: const Text('Idle'),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
