import 'package:flexiscan101/Patient/Cubit/states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FlexiCubit extends Cubit<FlexiStates>{
  FlexiCubit(): super (FlexiInitialState());
  static FlexiCubit get(context) =>BlocProvider.of(context);


  bool isPassword = true;
  IconData suffix = Icons.visibility;
  void changePasswordVisibility(){
    isPassword =! isPassword;
    suffix = isPassword? Icons.visibility : Icons.visibility_off;
    emit(FlexiChangePasswordVisibility());
  }

  bool isMaleSelected= false;
  void selectMale(){
    isMaleSelected = true;
    isFemaleSelected= false;
    emit(FlexiSelectMale());

  }

  bool isFemaleSelected= false;
  void selectFemale(){
    isMaleSelected = false;
    isFemaleSelected= true;
    emit(FlexiSelectFemale());

  }

  bool isFollowYes= false;
  void followYes(){
    isFollowYes= true;
    isFollowNo= false;
    emit(FlexiFollowYes());

  }

  bool isFollowNo= false;
  void followNo(){
    isFollowNo= true;
    isFollowYes= false;
    emit(FlexiFollowNo());
  }
}