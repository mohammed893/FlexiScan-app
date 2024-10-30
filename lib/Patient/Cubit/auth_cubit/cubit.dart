 import 'package:bloc/bloc.dart';
import 'package:flexiscan101/Patient/Cubit/auth_cubit/states.dart';
import 'package:flexiscan101/Patient/Models/login_model.dart';
import 'package:flexiscan101/Patient/Models/signup_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Network/dio_helper.dart';
import '../../../Network/end_points.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() :super(AuthInitialState());
  static AuthCubit get(context) =>BlocProvider.of(context);
  LoginModel? loginModel;
  SignupModel? signupModel;


  void login({
    required String email,
    required String password,
  }
      ){
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }).then((value){
      loginModel = LoginModel.fromJson(value.data);
      emit(AuthLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(AuthLoginErrorState(error.toString()));
    });
  }

  void signup({
    required String name,
    required String email,
    required String password,
    required String gender,
})
  {
    DioHelper.postData(
        url: SIGNUP,
        data: {
          'name':name,
          'email':email,
          'password':password,
          'gender':gender,
        }).then((value){
          signupModel = SignupModel.fromJson(value.data);
          emit(AuthSignupSuccessState(signupModel!));
    }).catchError((error){
      emit(AuthSignupErrorState(error));
    });
  }
}





