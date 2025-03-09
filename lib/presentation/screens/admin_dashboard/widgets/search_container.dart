import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class SearchContainer extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;

  const SearchContainer(
      {super.key, required this.controller, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(17)),
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: AppColors.primary,
        decoration: const InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'Search employees...',
          hintStyle: TextStyle(color: Colors.grey),
          prefixIcon: Icon(Icons.search, color: Colors.grey),
        ),
        onChanged: onSearch,
      ),
    );
  }
}
