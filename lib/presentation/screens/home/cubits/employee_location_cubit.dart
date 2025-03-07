import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

part 'employee_location_state.dart';

class EmployeeLocationCubit extends Cubit<EmployeeLocationState> {
  EmployeeLocationCubit() : super(EmployeeLocationInitial());
  final double companyLat = 30.0447;
  final double companyLng = 31.2389;
  final double geofenceRadius = 100;
  static final DateTime officialCheckInTime =
  DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 9, 0);
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkEmployeeLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        emit(EmployeeLocationPermissionDenied());
      }

      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

      double distance = Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          companyLat,
          companyLng,
      );

      if (distance <= geofenceRadius) {
        DateTime now = DateTime.now();
        bool isOnTime = now.isBefore(officialCheckInTime);
        emit(EmployeeLocationInside(
          checkInTime: now,
          isOnTime: isOnTime
        ));
      } else {
        emit(EmployeeLocationOutside());
      }
    } catch(e) {}
  }
  Future<void> checkIn() async {
    final user = _auth.currentUser;
    final now = DateTime.now();
    final checkInTime = "${now.hour.toString().padLeft(2, '0')}: ${now.minute.toString().padLeft(2, '0')}";

    final checkInData = {
      "employeeId": user?.uid,
      "checkInTime": checkInTime,
      "timestamp": now,
    };

    try {
      await _firestore
          .collection('user-attendance')
          .doc(user?.uid)
          .collection('attendance')
          .doc(DateTime.now().toString())
          .set(checkInData, SetOptions(merge: true));

      emit(EmployeeCheckedIn(time: checkInTime));
    } catch(e) {
      emit(EmployeeLocationError("Failed to check in: $e"));
    }
  }
}
