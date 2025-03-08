import 'package:flutter/material.dart';

class SettingsManager {
  static final SettingsManager _instance = SettingsManager._internal();

  factory SettingsManager() {
    return _instance;
  }

  SettingsManager._internal();

  void goToProfile(BuildContext context) {
    Navigator.pop(context);
  }
}