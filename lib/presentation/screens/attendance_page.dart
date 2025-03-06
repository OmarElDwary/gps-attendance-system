import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_bloc.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_event.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_state.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Dashboard'),
        centerTitle: true,
      ),
      body: BlocConsumer<AttendanceBloc, AttendanceState>(
        listener: (context, state) {
          if (state is AttendanceSuccess) {
            CustomSnackBar.show(
              context,
              'Attendance recorded successfully.',
            );
          } else if (state is AttendanceFailure) {
            CustomSnackBar.show(
              context,
              'Error: ${state.error}',
            );
          }
        },
        builder: (context, state) {
          if (state is AttendanceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<AttendanceBloc>().add(CheckInRequested());
                  },
                  child: const Text('Check In'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AttendanceBloc>().add(CheckOutRequested());
                  },
                  child: const Text('Check Out'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
