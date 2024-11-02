// modules/login/states.dart


abstract class LoginStates {}

class LoginInItialState extends LoginStates {}

class LoginSuccessState extends LoginStates {
 final String token;
  final String userId;
  final String? status;

  LoginSuccessState({required this.token, required this.userId, this.status});
}

class LoginLoadingState extends LoginStates {}

class LoginerorrState extends LoginStates {
 
 final String error;

    LoginerorrState(this.error);

}


class LoggedOutState extends LoginStates {}