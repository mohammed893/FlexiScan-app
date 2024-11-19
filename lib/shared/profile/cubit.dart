// shared/profile/cubit.dart
import 'package:bloc/bloc.dart';
import 'package:flexiscan101/Doctor/doctor_model.dart';
import 'package:flexiscan101/Patient/patient_model.dart';
import 'package:flexiscan101/shared/profile/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  static ProfileCubit get(context) => BlocProvider.of(context);

  PatientModel? patientModel;
  DoctorModel? doctorModel;

  bool isProfileComplete = false;
  bool isDoctor = false; 

  void checkProfileCompletion({required String userType}) {
    emit(ProfileLoadingState());

    if (userType == 'patient') {
      if (patientModel == null || patientModel?.name == null) {
        isProfileComplete = false;
        emit(ProfileIncompleteState());
      } else {
        isProfileComplete = true;
        emit(ProfileCompleteState());
      }
    } else if (userType == 'doctor') {
      if (doctorModel == null || doctorModel?.name == null) {
        isProfileComplete = false;
        emit(ProfileIncompleteState());
      } else {
        isProfileComplete = true;
        emit(ProfileCompleteState());
      }
    }
  }

  void updatePatientProfile(PatientModel model) {
    patientModel = model;
    isProfileComplete = true;
    isDoctor = false; // If a patient, he is not a doctor
    emit(ProfileCompleteState());
  }

  void updateDoctorProfile(DoctorModel model) {
    doctorModel = model;
    isProfileComplete = true;
    isDoctor = true; // If a doctor
    emit(ProfileCompleteState());
  }
}
