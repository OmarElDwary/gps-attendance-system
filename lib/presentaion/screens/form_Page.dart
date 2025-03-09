import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/models/leave_model.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/presentaion/screens/admin_dashboard/widgets/TexFeild_Custom.dart';
import 'package:intl/intl.dart';

class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({super.key});

  @override
  _ApplyLeaveScreenState createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  String? selectedLeaveType;

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  //--- Apply Leave Method ----//
  Future<void> _applyLeave() async {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (_formKey.currentState!.validate() && selectedLeaveType != null) {
      try {
        // var uuid = Uuid().v4();
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        // Create a leave model
        LeaveModel leaveModel = LeaveModel(
          title: titleController.text,
          leaveType: selectedLeaveType!,
          contactNumber: contactController.text,
          status: 'Pending',
          startDate:
              Timestamp.fromDate(DateTime.parse(startDateController.text)),
          endDate: Timestamp.fromDate(DateTime.parse(endDateController.text)),
          reason: reasonController.text,
          userId: userId ?? 'unknown',
        );
        // Save the leave to the database
        await firestore
            .collection('leaves')
            .doc(userId)
            .set(leaveModel.toMap());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Leave applied successfully!')),
        );

        titleController.clear();
        contactController.clear();
        startDateController.clear();
        endDateController.clear();
        reasonController.clear();
        setState(() {
          selectedLeaveType = null;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        title: const Text(
          'Apply Leave',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    labelText: 'Title',
                    hintText: 'Enter Title',
                    controller: titleController,
                  ),
                  CustomTextFormField(
                    labelText: 'Leave Type',
                    hintText: 'Select Leave Type',
                    isDropdown: true,
                    dropdownItems: const [
                      'Sick Leave',
                      'Casual Leave',
                      'Annual Leave',
                    ],
                    onChanged: (value) =>
                        setState(() => selectedLeaveType = value),
                  ),
                  CustomTextFormField(
                    labelText: 'Contact Number',
                    hintText: 'Enter Contact Number',
                    keyboardType: TextInputType.phone,
                    controller: contactController,
                  ),
                  CustomTextFormField(
                    labelText: 'Start Date',
                    hintText: 'Select Start Date',
                    controller: startDateController,
                    isDateField: true,
                    onDateTap: () => _selectDate(context, startDateController),
                  ),
                  CustomTextFormField(
                    labelText: 'End Date',
                    hintText: 'Select End Date',
                    controller: endDateController,
                    isDateField: true,
                    onDateTap: () => _selectDate(context, endDateController),
                  ),
                  CustomTextFormField(
                    labelText: 'Reason for Leave',
                    hintText: 'Enter Reason',
                    controller: reasonController,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _applyLeave,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Apply Leave',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
