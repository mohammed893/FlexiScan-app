// Network/dio_helper.dart
import 'package:dio/dio.dart';

class DioHelper{
  static late Dio dio;
  static init(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'http://3.80.117.242:3000/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    required Map <String, dynamic>  data,

  }) async {
    dio.options.headers ={};
    return dio.post(
      url,
      data: data,

    );
  }

  static Future<Response> getData({
    required String url,
  }) async{
    return await  dio.get(
      url,
       );
  }
}