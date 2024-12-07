import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class StickManController {
  static final StickManController _instance = StickManController._internal();
  factory StickManController() => _instance;
  StickManController._internal();
  SMINumber? _bend;
  final ValueNotifier<int> _levelNotifier = ValueNotifier<int>(0);
  final ValueNotifier<double> _progressNotifier = ValueNotifier<double>(0);

  void setBendInput(SMINumber? bend) {
    _bend = bend;
  }

  void setLevel(int level) {
    _levelNotifier.value = level;
    if (_bend != null) {
      _bend!.value = ((level - 1) * 0.3) + 0.1;
    }
  }

  void setProgression(double progress) {
    _progressNotifier.value = progress;
  }

  ValueNotifier<int> get levelNotifier => _levelNotifier;
}

class StickManScreen extends StatefulWidget {
  const StickManScreen({Key? key}) : super(key: key);

  @override
  State<StickManScreen> createState() => _StickManScreenState();
}

class _StickManScreenState extends State<StickManScreen> {
  late final Future<Artboard?> _riveArtboardFuture;

  @override
  void initState() {
    super.initState();
    RiveFile.initialize();
    _riveArtboardFuture = loadRiveFile();
  }

  Future<Artboard?> loadRiveFile() async {
    try {
      final data = await rootBundle.load('asset/stickman.riv');
      final file = RiveFile.import(data);
      final artboard = file.mainArtboard;

      var controller = StateMachineController.fromArtboard(artboard, "State Machine 1");
      if (controller != null) {
        artboard.addController(controller);
        StickManController().setBendInput(controller.findSMI('Bend'));
      }
      return artboard;
    } catch (e) {
      print("Error in initializing Rive File: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Artboard?>(
      future: _riveArtboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return Center(child: Text('Error loading Stick Man'));
        } else {
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular background
                Container(
  width: 300,
  height: 300,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    image: DecorationImage(
      image: AssetImage('asset/images/stickManBg.png'), // Path to your image
      fit: BoxFit.cover, // Adjusts how the image is fitted inside the circle
    ),
  ),
),
                // Rive artboard (inside the circle)
                Positioned(
                  top: 0, // Move the stickman down
                  child: ValueListenableBuilder<int>(
                    valueListenable: StickManController().levelNotifier,
                    builder: (context, level, child) {
                      return SizedBox(
                        width: 390, // Adjust the width to fit the artboard
                        height: 390, // Adjust the height to fit the artboard
                        child: Rive(artboard: snapshot.data!),
                      );
                    },
                  ),
                ),
                // Animated circular progress bar
                SizedBox(
                  width: 293,
                  height: 293,
                  child: ValueListenableBuilder<double>(
                    valueListenable: StickManController()._progressNotifier,
                    builder: (context, value, child) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: value),
                        duration: Duration(milliseconds: 500), // Animation duration
                        builder: (context, animatedValue, child) {
                          return CircularProgressIndicator(
                            value: animatedValue, // This will animate the progression
                            strokeWidth: 8,
                            backgroundColor: Colors.grey[500],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
