 import 'package:bloc/bloc.dart';
import 'package:flexiscan101/Auth/auth_cubit/states.dart';
import 'package:flexiscan101/Auth/Models/login_model.dart';
import 'package:flexiscan101/Auth/Models/signup_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Network/dio_helper.dart';
import '../../Network/end_points.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() :super(AuthInitialState());
  static AuthCubit get(context) =>BlocProvider.of(context);
  LoginModel? loginModel;
  SignupModel? signupModel;


  Future<void> login({
    required String email,
    required String password,
    required String userType
  }
      )async{
        emit(AuthLoadingState());
    await DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
          'type':userType
        }).then((value){
      print(value.data);
      loginModel = LoginModel.fromJson(value.data);
      emit(AuthLoginSuccessState(loginModel!));
    }).catchError((error){
      print(error);
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





