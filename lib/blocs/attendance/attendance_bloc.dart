import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_event.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_state.dart';
import 'package:gps_attendance_system/repositories/attendance_repository.dart';
import 'package:gps_attendance_system/utils/geofence_helper.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final AttendanceRepository attendanceRepository;

  AttendanceBloc({required this.attendanceRepository})
      : super(AttendanceInitial()) {
    on<CheckInRequested>(_onCheckInRequested);
    on<CheckOutRequested>(_onCheckOutRequested);
  }

  Future<void> _handleAttendance(
    String type,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceLoading());
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      bool allowed = await isWithinGeofence(position);
      if (!allowed) {
        emit(
          const AttendanceFailure(
            'You are not within the allowed geofence.',
          ),
        );
        return;
      }
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        emit(
          const AttendanceFailure('User not authenticated.'),
        );
        return;
      }
      await attendanceRepository.recordAttendance(
        userId: user.uid,
        type: type,
        latitude: position.latitude,
        longitude: position.longitude,
        timestamp: DateTime.now(),
      );
      emit(AttendanceSuccess());
    } catch (e) {
      emit(AttendanceFailure(e.toString()));
    }
  }

  Future<void> _onCheckInRequested(
    CheckInRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    await _handleAttendance('check-in', emit);
  }

  Future<void> _onCheckOutRequested(
    CheckOutRequested event,
    Emitter<AttendanceState> emit,
  ) async {
    await _handleAttendance('check-out', emit);
  }
}
