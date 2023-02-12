import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import '../main.dart';

enum PageRouteAnimation { Fade, Scale, Rotate, Slide, SlideBottomTop }

void hideKeyboard(context) => FocusScope.of(context).requestFocus(FocusNode());

/// Add a value in SharedPref based on their type - Must be a String, int, bool, double, Map<String, dynamic> or StringList
Future<bool> setValue(String key, dynamic value, {bool print = true}) async {
  if (print) log('${value.runtimeType} - $key - $value');

  if (value is String) {
    return await sharedPreferences.setString(key, value);
  } else if (value is int) {
    return await sharedPreferences.setInt(key, value);
  } else if (value is bool) {
    return await sharedPreferences.setBool(key, value);
  } else if (value is double) {
    return await sharedPreferences.setDouble(key, value);
  } else if (value is Map<String, dynamic>) {
    return await sharedPreferences.setString(key, jsonEncode(value));
  } else if (value is List<String>) {
    return await sharedPreferences.setStringList(key, value);
  } else {
    throw ArgumentError('Invalid value ${value.runtimeType} - Must be a String, int, bool, double, Map<String, dynamic> or StringList');
  }
}
