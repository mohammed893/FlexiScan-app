
import 'package:flexiscan101/Remote/BLE_COMM/screens/Scan.dart';
import 'package:flexiscan101/users/Patient/Cubit/states.dart';
import 'package:flexiscan101/users/Patient/NavScreens/devices.dart';
import 'package:flexiscan101/users/Patient/NavScreens/exercises.dart';
import 'package:flexiscan101/users/Patient/NavScreens/home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class FlexiCubit extends Cubit<FlexiStates>{
  FlexiCubit(): super (FlexiInitialState()){
    currentScreen = screens[currentIndex];
  }
  static FlexiCubit get(context) =>BlocProvider.of(context);
  static bool BLEConnected = false;
  List<Widget> get screens {return [
      const PatientHomeScreen(),
      const Exercises(),
      BLEConnected? const Devices() : ScanScreen() ,
    ];}
  int currentIndex = 0;

  late TextEditingController searchController;
  bool isPassword = true;
  IconData suffix = Icons.visibility;
  late Widget currentScreen;
  void updateBLEConnection(bool isConnected){
    BLEConnected = isConnected;
    emit(isConnected ? BLEConnectedState() : BLEDisconnectedState());
  }


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
  double rateValue = 0.0;
  void updateRate(double newRate){
    rateValue = newRate;
    emit(FlexiRateUpdatedState());  }

  double rate(){
    return rateValue;
  }


  void changeIndex(int index){
    currentIndex = index;
    currentScreen = screens[currentIndex];
    emit(ChangeIndex());
  }

  }






