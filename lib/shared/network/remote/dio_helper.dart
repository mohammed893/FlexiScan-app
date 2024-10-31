// shared/network/remote/dio_helper.dart

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  
  static late  Dio dio;
  static init (){
    dio = Dio(
      BaseOptions(
        baseUrl:'',
        receiveDataWhenStatusError: true,
         ),
        //  Headers{
        //   'content-type':'application/json',
        //  },
    );
  }
//

}