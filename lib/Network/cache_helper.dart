// shared/network/local/cache_helper.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

 // handling app modes light and dark
  static Future<bool> putBool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences?.setBool(key, value) ?? false; // Return false (bool) for null safety
  }

  
  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences?.get(key)?? false; // only get to use it for many types , initialized whith false for null safety
  }
}
 