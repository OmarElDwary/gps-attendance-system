import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/utils/attendance_helper.dart';

class ManagerDetailsPage extends StatelessWidget {
  final String managerName;
  final List<Map<String, String>> attendanceRecords = [
    {'date': 'April 10, 2023', 'checkIn': '10:12 am', 'checkOut': '07:00 am'},
    {'date': 'April 11, 2023', 'checkIn': '10:00 am', 'checkOut': '07:10 am'},
    {'date': 'April 12, 2023', 'checkIn': '09:50 am', 'checkOut': '07:00 am'},
    {'date': 'April 13, 2023', 'checkIn': '09:12 am', 'checkOut': '06:45 am'},
    {'date': 'April 14, 2023', 'checkIn': '10:00 am', 'checkOut': '07:00 am'},
  ];

  ManagerDetailsPage({super.key, required this.managerName});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('$managerName Attendance'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: attendanceRecords.length,
            itemBuilder: (context, index) {
              final record = attendanceRecords[index];
              String status =
                  AttendanceHelper.getAttendanceStatus(record['checkIn']!);
              Color statusColor = AttendanceHelper.getStatusColor(status);

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        record['date']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.045,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.login, color: Colors.green),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    record['checkIn']!,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.04),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(Icons.logout, color: Colors.red),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    record['checkOut']!,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        TextStyle(fontSize: screenWidth * 0.04),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.info, color: statusColor),
                          const SizedBox(width: 5),
                          Text(
                            status,
                            style: TextStyle(
                              color: statusColor,
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
