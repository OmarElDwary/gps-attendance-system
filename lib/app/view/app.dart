import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/themes/app_theme.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/admin_home.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/employess_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/geofence_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/managers_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/pending_approvals_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/settings_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/total_leaves_page.dart';
import 'package:gps_attendance_system/presentation/screens/home/check_in.dart';
import 'package:gps_attendance_system/presentation/screens/home/cubits/employee_location_cubit.dart';
import 'package:gps_attendance_system/presentation/screens/leaves.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => EmployeeLocationCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRoutes.userHome,
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case AppRoutes.userHome:
              return MaterialPageRoute(builder: (context) => const CheckIn());
            case AppRoutes.adminHome:
              return MaterialPageRoute(builder: (context) => AdminHome());
            case AppRoutes.employees:
              return MaterialPageRoute(
                builder: (context) => const EmployeesPage(),
              );
            case AppRoutes.managers:
              return MaterialPageRoute(
                builder: (context) => const ManagersPage(),
              );
            case AppRoutes.geofence:
              return MaterialPageRoute(
                builder: (context) => const GeofencePage(),
              );
            case AppRoutes.settings:
              return MaterialPageRoute(
                builder: (context) => const SettingsPage(),
              );
            case AppRoutes.totalLeaves:
              return MaterialPageRoute(
                builder: (context) => const TotalLeavesPage(),
              );
            case AppRoutes.pendingApprovals:
              return MaterialPageRoute(
                builder: (context) => const PendingApprovalsPage(),
              );
            case AppRoutes.leaves:
              return MaterialPageRoute(builder: (context) => const LeavesPage());
            default:
              return MaterialPageRoute(builder: (context) => AdminHome());
          }
        },
      ),
    );
  }
}
