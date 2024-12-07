import 'package:flexiscan101/animation_module/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';
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
  // -----------Old Animation Module (Not rely on Riv or .riv) ------------ (sanabl / Habiba Don't delete this)
  Map<String, Map<String, Tuple2<String, Duration>>> animationStates = {
    "error": {
      "standBy": const Tuple2("asset/images/Error_Start.gif", Duration(milliseconds: 833)),
      "Loop": const Tuple2("asset/images/Error_Start2.gif", Duration(milliseconds: 833)), // 3-second loop
      "return": const Tuple2("asset/images/Error_Start 3.gif", Duration(milliseconds: 833))
    },
    "Selected": {
      "standBy": const Tuple2("asset/images/Selected.gif", Duration(milliseconds: 833)),
      "Loop": const Tuple2("asset/images/Selected 2.gif", Duration(milliseconds: 833)),
      "return": const Tuple2("asset/images/Selected3.gif", Duration(milliseconds: 933))
    },
    "Flying": {
      "standBy": const Tuple2("asset/images/Fly1.gif", Duration(milliseconds: 667)),
      "Loop": const Tuple2("asset/images/Fly2.gif", Duration(milliseconds: 633)),
      "return": const Tuple2("asset/images/Fly2.gif", Duration(seconds: 1))
    }
  };

  String idleGif = "asset/images/Idle.gif";
  String currentState = "Idle";
  String currentGIF = "asset/images/Idle.gif";

  // Preload all GIFs
  void _preloadImages(BuildContext context) {
    // List of all image paths to preload
    List<String> imagePaths = [
      "asset/images/Error_Start.gif",
      "asset/images/Error_Start2.gif",
      "asset/images/Error_Start 3.gif",
      "asset/images/Selected.gif",
      "asset/images/Selected 2.gif",
      "asset/images/Selected3.gif",
      "asset/images/Fly1.gif",
      "asset/images/Fly2.gif",
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
  //-----------------------The New Module of animation Using Rive (.riv file)----------//
  Artboard? riveArtBoard;
  SMIBool? isFly;
  SMIBool? isError;
  SMIBool? isLookingDown;
  SMIBool? isSkin;
  String animaState = "Idle";
  late Map<String , SMIBool?> animaStates = {"Fly" : isFly ,
   "Error":isError ,
   "Selected" : isLookingDown 
    };
  Future<void> loadRiveFile () async {
    emit(LoadingFileState());
    await RiveFile.initialize();
    try {
      final data = await rootBundle.load('assets/test.riv');
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;
      var controller = StateMachineController.fromArtboard(artboard, "Motion");
      if(controller != null){
        artboard.addController(controller);
        isFly = controller.findSMI('Fly');
        isError = controller.findSMI('Error');
        isLookingDown = controller.findSMI('Looking Down');
        isSkin = controller.findSMI('Skin');
      }
      riveArtBoard = artboard;
      emit(LoadedFileState());
    }catch(e) {
      print("error in initializing Rive File ${e}");
    }
  }

   void toggleInput(SMIBool? input) {
    if (input != null) {
      input.value = !input.value;
      emit(ToggleState());
    }
  }

  void toggleAnimation(String stateName){
    if(animaState != stateName){
      if(stateName != "Idle"){
        toggleInput(animaStates[animaState]);
        animaState = "Idle";
              print(animaState);

      }
      toggleInput(animaStates[stateName]);
      animaState = stateName;
            print(animaState);

    }
    if(animaState != "Idle"){
      toggleInput(animaStates[animaState]);
        animaState = "Idle";
              print(animaState);

    }
  }

}

