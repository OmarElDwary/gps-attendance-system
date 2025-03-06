import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceRecord {
  final String id;
  final String userId;
  final String type; // 'check-in' or 'check-out'
  final double latitude;
  final double longitude;
  final DateTime timestamp;

  AttendanceRecord({
    required this.id,
    required this.userId,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory AttendanceRecord.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AttendanceRecord(
      id: doc.id,
      userId: data['userId'] as String,
      type: data['type'] as String,
      latitude: (data['latitude'] as num).toDouble(),
      longitude: (data['longitude'] as num).toDouble(),
      timestamp: DateTime.parse(data['timestamp'] as String),
    );
  }
}
