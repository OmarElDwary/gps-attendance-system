import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/app/app.dart';
import 'package:gps_attendance_system/bootstrap.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await bootstrap(App.new);
}
