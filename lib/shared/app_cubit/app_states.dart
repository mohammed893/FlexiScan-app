// shared/app_cubit/app_states.dart

import 'package:flutter/widgets.dart';

abstract class AppStates {}

 class initialState extends AppStates {}


 class LoadingHomeUserDataState extends AppStates {}

  class HomeUserDAtaSuccessState extends AppStates {

    String? username ;
    ImageProvider? profileimage;

    HomeUserDAtaSuccessState(  this.username , this.profileimage );

  }
  class changeAppModeState extends AppStates {

  }
 class OnBoardingFinishedState extends AppStates {}

  

