import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/app_navigator.dart';
import 'package:gps_attendance_system/blocs/auth/auth_cubit.dart';
import 'package:gps_attendance_system/core/app_routes.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/themes/app_theme.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/animation/fade.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/admin_home.dart';

import 'package:gps_attendance_system/presentation/screens/admin_dashboard/geofence_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/pending_approvals_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/settings_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/total_leaves_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/user_details_page.dart';
import 'package:gps_attendance_system/presentation/screens/admin_dashboard/users_page.dart';
import 'package:gps_attendance_system/presentation/screens/auth/add_user_page.dart';
import 'package:gps_attendance_system/presentation/screens/auth/login_page.dart';
import 'package:gps_attendance_system/presentation/screens/home/check_in.dart';
import 'package:gps_attendance_system/presentation/screens/home/cubits/employee_location_cubit.dart';
import 'package:gps_attendance_system/presentation/screens/leaves.dart';
import 'package:gps_attendance_system/presentation/screens/user_layout/home_layout.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => EmployeeLocationCubit()),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const AppNavigator(),
        onGenerateRoute: onGenerateRoute,

      ),
    );
  }
}

/////////////////////////////////////////////////////
//------------- On Generate Route ---------------//
Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.userHome:
      return MaterialPageRoute(builder: (context) => const CheckIn());
    case AppRoutes.adminHome:
      UserModel admin = settings.arguments! as UserModel;
      return FadePageTransition(
          page: AdminHome(
        admin: admin,
      ));
    case AppRoutes.employees:
      List<UserModel> users = settings.arguments! as List<UserModel>;
      return MaterialPageRoute(
        builder: (context) => UsersPage(users: users, isEmployees: true),
      );
    case AppRoutes.managers:
      List<UserModel> managers = settings.arguments! as List<UserModel>;
      return MaterialPageRoute(
        builder: (context) => UsersPage(users: managers, isEmployees: false),
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
      return MaterialPageRoute(
        builder: (context) => const LeavesPage(),
      );
    case AppRoutes.login:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
    case AppRoutes.addUser:
      return MaterialPageRoute(
        builder: (context) => const AddUserPage(),
      );
    case AppRoutes.userDetailsRoute:
      UserModel user = settings.arguments! as UserModel;
      return MaterialPageRoute(
        builder: (context) => UserDetailsPage(userModel: user),
      );
    case AppRoutes.homeLayoutRoute:
      return FadePageTransition(page: const HomeLayout());
    default:
      return FadePageTransition(page: const HomeLayout());
  }
}
