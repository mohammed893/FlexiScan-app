import 'package:flexiscan101/animation_module/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';

class AnimationCubit extends Cubit<AnimationStates> {
  late AnimationController _animationController;

  // Constructor now accepts both TickerProvider and BuildContext for preloading images
  AnimationCubit(TickerProvider vsync, BuildContext context) : super(initState()) {
    _animationController = AnimationController(vsync: vsync);

    // Preload all images when the cubit is created
    _preloadImages(context);
  }

  static AnimationCubit get(context) => BlocProvider.of<AnimationCubit>(context);
  void dispose() {
    _animationController.dispose();
  }

  Map<String, Map<String, Tuple2<String, Duration>>> animationStates = {
    "error": {
      "standBy": const Tuple2("assets/Error_Start.gif", Duration(milliseconds: 833)),
      "Loop": const Tuple2("assets/Error_Start2.gif", Duration(milliseconds: 833)), // 3-second loop
      "return": const Tuple2("assets/Error_Start 3.gif", Duration(milliseconds: 833))
    },
    "Selected": {
      "standBy": const Tuple2("assets/Selected.gif", Duration(milliseconds: 833)),
      "Loop": const Tuple2("assets/Selected 2.gif", Duration(milliseconds: 833)),
      "return": const Tuple2("assets/Selected3.gif", Duration(milliseconds: 933))
    },
    "Flying": {
      "standBy": const Tuple2("assets/Fly1.gif", Duration(milliseconds: 667)),
      "Loop": const Tuple2("assets/Fly2.gif", Duration(milliseconds: 633)),
      "return": const Tuple2("assets/Fly2.gif", Duration(seconds: 1))
    }
  };

  String idleGif = "assets/Idle.gif";
  String currentState = "Idle";
  String currentGIF = "assets/Idle.gif";

  // Preload all GIFs
  void _preloadImages(BuildContext context) {
    // List of all image paths to preload
    List<String> imagePaths = [
      "assets/Error_Start.gif",
      "assets/Error_Start2.gif",
      "assets/Error_Start 3.gif",
      "assets/Selected.gif",
      "assets/Selected 2.gif",
      "assets/Selected3.gif",
      "assets/Fly1.gif",
      "assets/Fly2.gif",
      idleGif,
    ];

    // Preload each image
    for (String imagePath in imagePaths) {
      precacheImage(AssetImage(imagePath), context);
    }
  }

  Future<void> changeFromIdle(String newState, ) async {
    if(currentState != newState){
      currentGIF = animationStates[newState]!["standBy"]!.item1;
      emit(StagingNewState());

    // Start the "standBy" state duration
    await Future.delayed(animationStates[newState]!["standBy"]!.item2);

    // Reset the controller before transitioning to the loop state
    _animationController.reset();

    // Now transition to the Loop GIF and start controlling the animation timing
    currentGIF = animationStates[newState]!["Loop"]!.item1;
    currentState = newState;
    emit(LoopState());

    // Control the duration of the Loop state using AnimationController
    _animationController.duration = animationStates[newState]!["Loop"]!.item2 * 5; // Loop for 3 times
    _animationController.repeat(); // Use repeat to loop the animation

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
        // When the loop completes, transition to the return animation
        print("Idle from animation controller");
        changeToIdle(newState);
      }
    });
    }    
  }

  Future<void> changeToIdle(String fromState) async {
    if (fromState != "Idle") {
      // Stop the animation controller
      _animationController.stop();

      // Reset the controller before transitioning back to idle
      _animationController.reset();

      currentGIF = animationStates[fromState]!["return"]!.item1;
      emit(StagingNewState());
      await Future.delayed(animationStates[fromState]!["return"]!.item2);

      // Transition to idle GIF
      currentGIF = idleGif;
      currentState = "Idle";
      emit(IdleState());
    }
  }
}
