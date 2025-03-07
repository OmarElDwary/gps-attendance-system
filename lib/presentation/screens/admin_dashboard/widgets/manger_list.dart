import 'package:flutter/material.dart';
import 'package:gps_attendance_system/core/themes/app_colors.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/mangers_details_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/widgets/custom_list_tile.dart';

class ManagersList extends StatelessWidget {
  const ManagersList({
    required this.dummyManagers,
    super.key,
  });

  final List<String> dummyManagers;

  @override
  Widget build(BuildContext context) {
    double avatarRadius = MediaQuery.of(context).size.width * 0.08;

    return ListView.builder(
      // physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: dummyManagers.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.only(bottom: 8),
          child: CustomListTile(
            // user name
            title: dummyManagers[index],
            // user photo
            widget: CircleAvatar(
              backgroundColor: AppColors.primary,
              // radius: 28,
              radius: avatarRadius,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ManagerDetailsPage(managerName: dummyManagers[index]),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
