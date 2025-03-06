import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_state.dart';
import 'package:gps_attendance_system/presentation/screens/attendance_page.dart';
import 'package:gps_attendance_system/presentation/screens/login_page.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.watch<AuthBloc>(),
      builder: (context, state) {
        if (state is Authenticated) {
          return const AttendancePage();
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
