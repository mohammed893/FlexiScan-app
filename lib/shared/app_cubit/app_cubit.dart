// shared/app_cubit/app_cubit.dart

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';


import '../network/local/cache_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(initialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({
    bool? currentModeFromPrefs,
  }) {
    if (currentModeFromPrefs != null) {
      isDark = currentModeFromPrefs;
      emit(changeAppModeState());
    } else {
      isDark = !isDark;
      CachHelper.putBool(key: 'isDark', value: isDark).then((val) {
        emit(changeAppModeState());
      });
    }
  }

  // Function to check if onboarding was completed
  bool? isOnboardingFinished() {
    return CachHelper.getData(key: 'onBoarding');
  }

  // Function to set onboarding as completed
  void finishOnboarding() {
    CachHelper.putBool(key: 'onBoarding', value: true).then((value) {
      emit(OnBoardingFinishedState());
    });
  }

  void navigateToNextPage({
    required context,
    required nextPage,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextPage),
    );
  }



}
