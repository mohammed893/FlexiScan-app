// shared/network/local/cache_helper.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachHelper {
  static SharedPreferences? sharedPreferences;

  // Initialize SharedPreferences
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences?.setBool(key, value) ?? false; 
  }

  static dynamic getData({
    required String key,
  }) {
    if (sharedPreferences == null) {
      return null; 
    }
    
    return sharedPreferences!.get(key); 
  }
}
