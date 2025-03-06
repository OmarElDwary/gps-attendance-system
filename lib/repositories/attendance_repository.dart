import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> recordAttendance({
    required String userId,
    required String type,
    required double latitude,
    required double longitude,
    required DateTime timestamp,
  }) async {
    await _firestore.collection('attendanceRecords').add({
      'userId': userId,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'timestamp': timestamp.toIso8601String(),
    });
  }
}
