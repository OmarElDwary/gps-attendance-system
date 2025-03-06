import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/app_navigator.dart';
import 'package:gps_attendance_system/blocs/attendance/attendance_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_bloc.dart';
import 'package:gps_attendance_system/blocs/auth/auth_event.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/repositories/attendance_repository.dart';

class App extends StatelessWidget {
  App({super.key});

  final AttendanceRepository attendanceRepository = AttendanceRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc()..add(AppStarted()),
        ),
        BlocProvider<AttendanceBloc>(
          create: (_) =>
              AttendanceBloc(attendanceRepository: attendanceRepository),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: AppNavigator(),
      ),
    );
  }
}
