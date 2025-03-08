
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'employee_location_state.dart';

class EmployeeLocationCubit extends Cubit<EmployeeLocationState> {
  EmployeeLocationCubit() : super(EmployeeLocationInitial());
  final double companyLat = 30.0447;
  final double companyLng = 31.2389;
  final double geofenceRadius = 100;

  static final DateTime officialCheckInTime = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // get object
  static EmployeeLocationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  //--- Check employee location method ---//
  Future<bool> checkEmployeeLocation() async {
    bool isInside = false;

    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        emit(EmployeeLocationPermissionDenied());
      }


      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        companyLat,
        companyLng,

      );

      if (distance <= geofenceRadius) {
        DateTime now = DateTime.now();
        bool isOnTime = now.isBefore(officialCheckInTime);
        isInside = true;
        emit(EmployeeLocationInside(checkInTime: now, isOnTime: isOnTime));
      } else {
        isInside = false;
        log('Error: You are not inside the geofence.');
        emit(EmployeeLocationOutside('You are not inside the geofence.'));
      }
    } catch (e) {
      isInside = false;
      print('Error checking employee location: $e');
      emit(EmployeeLocationError('Failed to check employee location: $e'));
    }
    return isInside;
  }

  //--- Check in method to save attendance ---//
  Future<void> checkIn() async {
    final user = _auth.currentUser;
    final now = DateTime.now();
    final checkInTime =
        "${now.hour.toString().padLeft(2, '0')}: ${now.minute.toString().padLeft(2, '0')}";

    final checkInData = {
      'employeeId': user?.uid,
      'checkInTime': checkInTime,
      'timestamp': now,

    };

    try {
      await _firestore
          .collection('user-attendance')
          .doc(user?.uid)
          .collection('attendance')
          .doc(DateTime.now().toString())
          .set(checkInData, SetOptions(merge: true));

      emit(EmployeeCheckedIn(time: checkInTime));

    } catch (e) {
      print('Error failed to check in: $e');
      emit(EmployeeLocationError('Failed to check in: $e'));

    }
  }
}
