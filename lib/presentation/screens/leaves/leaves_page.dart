import 'package:flutter/material.dart';
import 'package:gps_attendance_system/presentation/screens/form_Page.dart';
import 'package:gps_attendance_system/presentation/screens/leaves/widgets/custom_button.dart';
import 'package:gps_attendance_system/presentation/screens/leaves/widgets/leaves_status_square.dart';

class LeavesPage extends StatelessWidget {
  const LeavesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  color: Colors.black.withValues(alpha: 0.8),
                ),
              ),
              const SizedBox(height: 16),
              //------ Leave Status Squares ------//
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
              //------ Upcoming Leaves list ------//
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  ListTile(
                    title: Text('JAN 15, 2025 - JAN 18, 2025'),
                    subtitle: Text('Approved by Admin'),
                    trailing: Text('3 Days'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              //-------- Request Leave Button --------//
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: CustomButton(
                  text: 'Request a Leave',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ApplyLeaveScreen(
                                  userId: '',
                                )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
