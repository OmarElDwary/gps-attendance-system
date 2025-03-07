import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/user_details_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_list_tile.dart';

class UsersList extends StatelessWidget {
  final List<String> dummyEmployees;

  const UsersList({required this.dummyEmployees, super.key});

  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.08;

    return ListView.builder(
      shrinkWrap: true,
      itemCount: dummyEmployees.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 8),
          child: CustomListTile(
            title: dummyEmployees[index],
            widget: CircleAvatar(
              backgroundColor: AppColors.primary,
              radius: avatarRadius,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      UserDetailsPage(userName: dummyEmployees[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
