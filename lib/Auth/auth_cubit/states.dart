import '../Models/login_model.dart';
import '../Models/signup_model.dart';

abstract class AuthStates{}

class AuthInitialState extends AuthStates{}

class AuthLoginSuccessState extends AuthStates{
  final LoginModel loginModel;
  AuthLoginSuccessState(this.loginModel);
}

class AuthLoginErrorState extends AuthStates{
  final String error;
  AuthLoginErrorState(this.error);
}

class AuthLoadingState extends AuthStates{}

class AuthSignupSuccessState extends AuthStates{
  final SignupModel signupModel;
  AuthSignupSuccessState(this.signupModel);
}

class AuthSignupErrorState extends AuthStates{
  final String error;
  AuthSignupErrorState(this.error);
}