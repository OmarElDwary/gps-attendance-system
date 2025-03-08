import 'package:flutter/material.dart';

import 'package:gps_attendance_system/core/app_routes.dart';


class LeavesPage extends StatelessWidget {
  const LeavesPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Center(
      child: IconButton(
        icon: const Icon(Icons.add),
        onPressed: () {
         Navigator.pushNamed(
                context,
                AppRoutes.requestLeave,
              );
        },

      ),
    );
  }
}
