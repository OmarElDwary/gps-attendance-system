import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/core/app_strings.dart';
import 'package:gps_attendance_system/core/services/shared_prefs_service.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/admin_home.dart';
import 'package:gps_attendance_system/presentation/screens/auth/login_page.dart';
import 'package:gps_attendance_system/presentation/screens/user_layout/home_layout.dart';


class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthStates>(
      builder: (context, state) {
        // get user role from shared pref
        String? userRole =
            SharedPrefsService.getStringData(key: AppStrings.roleKey);
        print('user role: $userRole');
        if (state is Authenticated) {
          // check user role first
          // if admin -> navigate to admin dashboard
          // else -> navigate to user home page
          if (userRole == 'admin') {
            return AdminHome();
          } else {
            return const HomeLayout();
          }
        } else if (state is Unauthenticated) {
          return const LoginPage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
