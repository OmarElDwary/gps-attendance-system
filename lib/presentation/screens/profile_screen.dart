import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/models/attendance_record.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: const Center(child: Text('User not authenticated')),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('attendanceRecords')
            .where('userId', isEqualTo: userId)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading records'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('No attendance records found.'));
          }
          final records = docs.map(AttendanceRecord.fromDocument).toList();

          return ListView.builder(
            itemCount: records.length,
            itemBuilder: (context, index) {
              final record = records[index];
              return ListTile(
                title:
                    Text(record.type == 'check-in' ? 'Check In' : 'Check Out'),
                subtitle: Text('Time: ${record.timestamp.toLocal()}'),
                trailing: Text(
                    'Lat: ${record.latitude.toStringAsFixed(2)}, Lon: ${record.longitude.toStringAsFixed(2)}'),
              );
            },
          );
        },
      ),
    );
  }
}
