import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/utils/attendance_helper.dart';
import 'package:intl/intl.dart';

class UserDetailsPage extends StatelessWidget {
  final String userName;
  final List<Map<String, String>> attendanceRecords = [
    {'date': '2023-04-10', 'checkIn': '10:12 am', 'checkOut': '07:00 pm'},
    {'date': '2023-04-11', 'checkIn': '12:00 am', 'checkOut': '07:10 pm'},
    {'date': '2023-04-12', 'checkIn': '09:50 am', 'checkOut': '07:00 pm'},
    {'date': '2023-04-13', 'checkIn': '09:12 am', 'checkOut': '06:45 pm'},
    {'date': '2023-04-14', 'checkIn': '10:30 am', 'checkOut': '07:00 pm'},
  ];

  UserDetailsPage({required this.userName, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text('$userName Attendance')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: ListView.builder(
          itemCount: attendanceRecords.length,
          itemBuilder: (context, index) {
            final record = attendanceRecords[index];
            String formattedDate = DateFormat('MMMM dd, yyyy')
                .format(DateTime.parse(record['date']!));
            String status =
                AttendanceHelper.getAttendanceStatus(record['checkIn']!);
            Color statusColor = AttendanceHelper.getStatusColor(status);

            return Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(formattedDate,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.login, color: Colors.green),
                        const SizedBox(width: 5),
                        Text("Check-In: ${record['checkIn']}"),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.logout, color: Colors.red),
                        const SizedBox(width: 5),
                        Text("Check-Out: ${record['checkOut']}"),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.info, color: statusColor),
                        const SizedBox(width: 5),
                        Text(status,
                            style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
