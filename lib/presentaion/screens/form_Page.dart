import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentaion/screens/admin_dashboard/widgets/TexFeild_Custom.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class ApplyLeaveScreen extends StatefulWidget {
  final String userId;

  const ApplyLeaveScreen({Key? key, required this.userId}) : super(key: key);

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

  void _applyLeave() async {
    if (_formKey.currentState!.validate() &&
        selectedLeaveType != null &&
        startDateController.text.isNotEmpty &&
        endDateController.text.isNotEmpty) {
      try {
        var uuid = Uuid().v4();
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        await firestore.collection('leaves').doc(uuid).set({
          'id': uuid,
          'title': titleController.text,
          'leaveType': selectedLeaveType!,
          'contactNumber': contactController.text,
          'startDate': Timestamp.fromDate(DateTime.parse(startDateController.text)),
          'endDate': Timestamp.fromDate(DateTime.parse(endDateController.text)),
          'reason': reasonController.text,
          'userId': FirebaseAuth.instance.currentUser?.uid ?? 'unknown',
          'createdAt': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.leaveAppliedSuccessfully)),
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
        SnackBar(content: Text(AppLocalizations.of(context)!.pleaseFillAllFields)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.applyLeave,
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onPrimary),
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
                    labelText: AppLocalizations.of(context)!.title,
                    hintText: AppLocalizations.of(context)!.enterTitle,
                    controller: titleController,
                  ),
                  CustomTextFormField(
                    labelText: AppLocalizations.of(context)!.leaveType,
                    hintText: AppLocalizations.of(context)!.selectLeaveType,
                    isDropdown: true,
                    dropdownItems:
                    [
                      AppLocalizations.of(context)!.sickLeave,
                      AppLocalizations.of(context)!.casualLeave,
                      AppLocalizations.of(context)!.annualLeave
                    ],
                    onChanged: (value) => setState(() => selectedLeaveType = value),
                  ),
                  CustomTextFormField(
                    labelText: AppLocalizations.of(context)!.contactNumber,
                    hintText: AppLocalizations.of(context)!.enterContactNumber,
                    keyboardType: TextInputType.phone,
                    controller: contactController,
                  ),
                  CustomTextFormField(
                    labelText: AppLocalizations.of(context)!.startDate,
                    hintText: AppLocalizations.of(context)!.selectStartDate,
                    controller: startDateController,
                    isDateField: true,
                    onDateTap: () => _selectDate(context, startDateController),
                  ),
                  CustomTextFormField(
                    labelText: AppLocalizations.of(context)!.endDate,
                    hintText: AppLocalizations.of(context)!.selectEndDate,
                    controller: endDateController,
                    isDateField: true,
                    onDateTap: () => _selectDate(context, endDateController),
                  ),
                  CustomTextFormField(
                    labelText: AppLocalizations.of(context)!.reasonForLeave,
                    hintText: AppLocalizations.of(context)!.enterReason,
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
                      child: Text(
                        AppLocalizations.of(context)!.applyLeave,
                        style: TextStyle(
                          fontSize: 16,
                          color : AppColors.whiteColor
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
