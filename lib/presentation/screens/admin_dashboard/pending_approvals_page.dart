import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/leaves_admin/leaves_cubit.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/leave_card.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

// dummy leaves
List<LeaveModel> dummyPendingLeaves = [
  LeaveModel(
    title: 'Casual',
    leaveType: 'Casual Leave',
    contactNumber: '01062197942',
    startDate: Timestamp.fromDate(DateTime.now()),
    endDate: Timestamp.fromDate(DateTime.now()),
    reason: 'this reason',
    userId: FirebaseAuth.instance.currentUser!.uid,
    id: '4444',
  ),
  LeaveModel(
    title: 'Casual',
    leaveType: 'Casual Leave',
    contactNumber: '01062197942',
    startDate: Timestamp.fromDate(DateTime.now()),
    endDate: Timestamp.fromDate(DateTime.now()),
    reason: 'this reason',
    userId: FirebaseAuth.instance.currentUser!.uid,
    id: '4444',
  ),
];

class PendingApprovalsPage extends StatelessWidget {
  const PendingApprovalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pending Approvals'),
      ),
      body: BlocBuilder<LeavesCubit, LeavesState>(
        builder: (context, state) {
          List<LeaveModel> pendingLeaves = [];
          if (state is LeavesLoaded) {
            pendingLeaves = state.pendingLeaves;
          }
          if (state is LeavesError) {
            CustomSnackBar.show(
              context,
              state.message,
              color: chooseSnackBarColor(ToastStates.ERROR),
            );
          }
          // Date formatter
          final dateFormat = DateFormat('yyyy-MM-dd');
          return Skeletonizer(
            enabled: state is GetLeavesLoading,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 16),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  final leave = pendingLeaves.isEmpty
                      ? dummyPendingLeaves[index]
                      : pendingLeaves[index];
                  final startDate = dateFormat.format(leave.startDate.toDate());
                  final endDate = dateFormat.format(leave.endDate.toDate());
                  int noOfDays = leave.endDate
                      .toDate()
                      .difference(leave.startDate.toDate())
                      .inDays;
                  return LeaveCard(
                    startDate: startDate,
                    endDate: endDate,
                    leave: leave,
                    noOfDays: noOfDays,
                  );
                },
                itemCount: pendingLeaves.isEmpty
                    ? dummyPendingLeaves.length
                    : pendingLeaves.length,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

///////////////////////////////
