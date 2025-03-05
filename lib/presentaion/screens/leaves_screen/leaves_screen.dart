import 'package:flutter/material.dart';
import 'package:gps_attendance_system/presentaion/screens/leaves_screen/widgets/custom_button.dart';
import 'package:gps_attendance_system/presentaion/screens/leaves_screen/widgets/leaves_status_square.dart';

class LeavesScreen extends StatelessWidget {
  const LeavesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Management'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'All Leaves',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  LeaveStatusSquare(
                    title: 'Leave Balance',
                    count: 20,
                    color: Colors.green,
                    opacity: 0.2,
                  ),
                  LeaveStatusSquare(
                    title: 'Approved',
                    count: 2,
                    color: Colors.blue,
                    opacity: 0.2,
                  ),
                  LeaveStatusSquare(
                    title: 'Pending',
                    count: 4,
                    color: Colors.orange,
                    opacity: 0.2,
                  ),
                  LeaveStatusSquare(
                    title: 'Cancelled',
                    count: 10,
                    color: Colors.red,
                    opacity: 0.2,
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const Text(
                'Upcoming Leaves',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView(
                  children: const [
                    ListTile(
                      title: Text('JAN 15, 2025 - JAN 18, 2025'),
                      subtitle: Text('Approved by Admin'),
                      trailing: Text('3 Days'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton(
                  text: 'Request a Leave',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
