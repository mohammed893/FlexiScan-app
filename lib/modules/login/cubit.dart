// modules/login/cubit.dart

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flexiscan101/modules/login/states.dart';
import 'package:flexiscan101/shared/endpoints.dart';
import 'package:flexiscan101/shared/network/local/secure_data.dart';


class AuthCubit extends Cubit<LoginStates> {
  final SecureStorage _secureStorage = SecureStorage();
  final Dio _dio = Dio(); 

  AuthCubit() : super(LoginInItialState());

  Future login(String username, String password) async {
    emit(LoginLoadingState());

    try {
      Response response = await _dio.post(
        loginendpoint,
        data: {
          'username': username,
          'password': password,
        },
      );

      final String token = response.data['token'];
      final String userId = response.data['id'];

      await _secureStorage.write('token', token);
      await _secureStorage.write('userId', userId);

      emit(LoginSuccessState(token: token, userId: userId, ));
    } catch (error) {
      emit(LoginerorrState("Login failed: ${error.toString()}"));
    }
  }

  Future<void> loadUserData() async {
    final String? token = await _secureStorage.read('token');
    final String? userId = await _secureStorage.read('userId');

    if (token != null && userId != null) {
      emit(LoginSuccessState(token: token, userId: userId));
    } else {
      emit(LoggedOutState());
    }
  }

  // // Function to log out (will be used later)
  // Future<void> logout() async {
  //   await _secureStorage.delete('token');
  //   await _secureStorage.delete('userId');
  //   emit(LoggedOutState());
  // }
}
