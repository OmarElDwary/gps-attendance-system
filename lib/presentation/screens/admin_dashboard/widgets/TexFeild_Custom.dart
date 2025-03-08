import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isDropdown = false,
    this.isDateField = false,
    this.dropdownItems,
    this.onChanged,
    this.onDateTap,
  }) : super(key: key);
  final String labelText;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isDropdown;
  final bool isDateField;
  final List<String>? dropdownItems;
  final void Function(String?)? onChanged;
  final VoidCallback? onDateTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isDropdown
          ? DropdownButtonFormField<String>(
              decoration: _buildInputDecoration(),
              items: dropdownItems
                  ?.map((item) => DropdownMenuItem(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )))
                  .toList(),
              dropdownColor: AppColors.whiteColor,
              onChanged: onChanged,
            )
          : TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              readOnly: isDateField,
              onTap: isDateField ? onDateTap : null,
              decoration: _buildInputDecoration(
                suffixIcon: isDateField ? Icons.calendar_today : null,
              ),
              validator: (value) => value == null || value.isEmpty
                  ? "Please enter $labelText"
                  : null,
            ),
    );
  }

  InputDecoration _buildInputDecoration({IconData? suffixIcon}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: AppColors.blackColor),
      hintText: hintText,
      hintStyle: const TextStyle(color: AppColors.fifthColor),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.thirdMintGreen)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.thirdMintGreen)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.fifthColor)),
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: AppColors.fourthColor)
          : null,
    );
  }
}
