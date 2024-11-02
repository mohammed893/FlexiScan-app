 import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flexiscan101/Auth/auth_cubit/states.dart';
import 'package:flexiscan101/Auth/Models/login_model.dart';
import 'package:flexiscan101/Auth/Models/signup_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Network/dio_helper.dart';
import '../../Network/end_points.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() :super(AuthInitialState());

  static AuthCubit get(context) => BlocProvider.of(context);
  LoginModel? loginModel;
  SignupModel? signupModel;


  Future<void> login({
    required String email,
    required String password,
    required String userType
  }) async {
    emit(AuthLoadingState());
    await DioHelper.postData(
        url: LOGIN,
        data: {
          'email': email,
          'password': password,
          'type': userType
        }).then((value) {
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(AuthLoginSuccessState(loginModel!));
    }).catchError((error) {
      print(error);
      emit(AuthLoginErrorState(error.toString()));
    });
  }

  void signup({
    required String name,
    required String email,
    required String password,
    required String dateOfBirth,
    required String gender,
    required String hospital,
    required String verification,
    required String type,
    required String age,
    required String phoneNumber,
    required String nationalID,
    required bool follow
  }) async {
    try {
      final value = await DioHelper.postData(
        url: SIGNUP,
        data: {
          'fullname': name,
          'email': email,
          'password': password,
          'Date_of_birth': dateOfBirth,
          'Gender': gender,
          'Hospital': hospital,
          'verification': verification,
          'type': type,
          'Age': age,
          'PhoneNumber': phoneNumber,
          'nationalID': nationalID,
          'follow_up' : follow,
        },
      );

      signupModel = SignupModel.fromJson(value.data);
      emit(AuthSignupSuccessState(signupModel!));
    } on DioException catch (e) {
      String errorMessage = e.message ?? "unexpected error";
      emit(AuthSignupErrorState(errorMessage));
    } catch (error) {
      emit(AuthSignupErrorState('unexpected error'));
    }
  }
}