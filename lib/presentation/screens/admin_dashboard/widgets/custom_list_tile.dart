import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    required this.widget,
    super.key,
    this.onTap,
  });

  final String title;
  final Widget widget;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      focusColor: AppColors.secondary,
      hoverColor: AppColors.secondary,
      selectedColor: AppColors.secondary,
      iconColor: AppColors.thirdMintGreen,
      title: Text(title),
      leading: widget,
      onTap: onTap,
    );
  }
}
