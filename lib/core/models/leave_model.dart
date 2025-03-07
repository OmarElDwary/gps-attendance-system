import 'package:cloud_firestore/cloud_firestore.dart';

class LeaveModel {
  String id;
  String title;
  String leaveType;
  String contactNumber;
  Timestamp startDate;
  Timestamp endDate;
  String reason;
  String userId;

  LeaveModel({
    required this.id,
    required this.title,
    required this.leaveType,
    required this.contactNumber,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'leaveType': leaveType,
      'contactNumber': contactNumber,
      'startDate': startDate,
      'endDate': endDate,
      'reason': reason,
      'userId': userId,
    };
  }

  factory LeaveModel.fromMap(Map<String, dynamic> map, String documentId) {
    return LeaveModel(
      id: documentId,
      title: map['title']?.toString() ?? '',
      leaveType: map['leaveType']?.toString() ?? '',
      contactNumber: map['contactNumber']?.toString() ?? '',
      startDate: (map['startDate'] is Timestamp) ? map['startDate'] as Timestamp : Timestamp.now(),
      endDate: (map['endDate'] is Timestamp) ? map['endDate'] as Timestamp : Timestamp.now(),
      reason: map['reason']?.toString() ?? '',
      userId: map['userId']?.toString() ?? '',
    );
  }
}
